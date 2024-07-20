import 'package:flutter/material.dart';

// List of features to be searched
final List<String> features = [
  "Crop Recommendation",
  "Fertilizer Recommendation",
  "Crop Disease Prediction"
];

// Function to search features
List<String> searchFeatures(String query) {
  return features.where((feature) {
    return feature.toLowerCase().contains(query.toLowerCase());
  }).toList();
}

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();
  List<String> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
              size: 26,
            ),
            suffixIcon: const Icon(
              Icons.mic,
              color: Colors.green,
              size: 26,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Search your topic",
            labelStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            isDense: true,
          ),
          onChanged: (value) {
            setState(() {
              _searchResults = searchFeatures(value);
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_searchResults[index]),
                onTap: () {
                  // Handle navigation to respective feature
                  print('Tapped on: ${_searchResults[index]}');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Feature Search Demo'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SearchTextField(),
        ),
      ),
    );
  }
}
