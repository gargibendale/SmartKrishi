import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:io';
import 'package:agri/api_key.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String _response = '';
  File? _image;
  String _selectedLanguage = 'English'; // Default language
  final Map<String, String> _languages = {
    'English': 'en',
    'हिन्दी': 'hi',
    'বাংলা': 'bn',
  };

  final Map<String, String> _translations = {
    'en': 'English',
    'hi': 'Hindi',
    'bn': 'Bengali',
  };

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
        print('Image picked: ${image.path}');
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> giveResponse(File image) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest', // Updated model for multimodal input
        apiKey: GOOGLE_API_KEY,
      );

      final imageBytes = await image.readAsBytes();
      final fixedPrompt =
          'This image contains a plant disease. Identify the disease. Also give its cure and prevention. Answer in ${_translations[_languages[_selectedLanguage]]}.';
      final promptContent = TextPart(fixedPrompt);
      final imagePart = DataPart('image/jpeg', imageBytes);

      print(
          'Sending request with prompt: $fixedPrompt and image size: ${imageBytes.length} bytes');

      final response = await model.generateContent([
        Content.multi([promptContent, imagePart])
      ]);

      setState(() {
        _response = response.text ?? 'No response text';
      });
      print('Response received: ${response.text}');
    } catch (e) {
      print('Error generating response: $e');
      setState(() {
        _response = 'Error generating response: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Detector'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLanguage = newValue!;
                    });
                    print('Selected language: $_selectedLanguage');
                  },
                  items: _languages.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: pickImage,
                  child: const Text('Pick Image'),
                ),
                const SizedBox(height: 20),
                _image != null
                    ? Image.file(
                        _image!,
                        height: 200,
                      )
                    : const Text('No image selected.'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _image != null
                      ? () {
                          print('Button pressed with fixed prompt.');
                          giveResponse(_image!);
                        }
                      : null,
                  child: const Text('Identify Disease'),
                ),
                const SizedBox(height: 20),
                _response.isNotEmpty
                    ? MarkdownBody(
                        data: _response,
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(color: Colors.black),
                        ),
                      )
                    : const Text('No response yet.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
