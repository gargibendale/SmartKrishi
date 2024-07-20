import 'package:flutter/material.dart';


class LanguageSelectionDialog extends StatelessWidget {
  final Function(String) onLanguageSelected;

  const LanguageSelectionDialog({Key? key, required this.onLanguageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('English'),
            onTap: () => _selectLanguage(context, 'en'),
          ),
          ListTile(
            title: Text('हिन्दी'),
            onTap: () => _selectLanguage(context, 'hi'),
          ),
          ListTile(
            title: Text('मराठी'),
            onTap: () => _selectLanguage(context, 'mr'),
          ),
          // Add more languages as needed
        ],
      ),
    );
  }

  void _selectLanguage(BuildContext context, String languageCode) {
    onLanguageSelected(languageCode);
    Navigator.of(context).pop();
  }
}
