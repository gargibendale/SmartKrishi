import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:agri/api_key.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  void giveResponse() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: GOOGLE_API_KEY,
    );

    final prompt = 'Write a story about a magic backpack.';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    print(response.text);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
