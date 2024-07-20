import 'package:agri/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations/app_localizations.dart';
// Update the import path if necessary
//import 'package:your_package_name/dialog/language_selection_dialog.dart'; // Correct the path // Assuming you have a LanguageSelectionDialog

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('selected_language') ?? 'en';
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', languageCode);

    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
      ],
      home: farmerfeats(onLanguageChanged: _changeLanguage),
    );
  }
}

class farmerfeats extends StatelessWidget {
  final Function(String) onLanguageChanged;

  farmerfeats({required this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.white,
        title: Text(localizations?.translate('Feats of Great Indian Farmers') ??
            'Feats of Great Indian Farmers'),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => LanguageSelectionDialog(
                  onLanguageSelected: (String languageCode) {
                    onLanguageChanged(languageCode);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          FarmerCard(
            name: localizations?.translate('Rajkumari Devi (Kisan Chachi)') ??
                'Rajkumari Devi (Kisan Chachi)',
            story: localizations?.translate(
                    'Known for her work in organic farming and empowering women through self-help groups in Bihar.') ??
                'Known for her work in organic farming and empowering women through self-help groups in Bihar.',
          ),
          FarmerCard(
            name:
                localizations?.translate('Babulal Dahiya') ?? 'Babulal Dahiya',
            story: localizations?.translate(
                    'An organic farmer from Madhya Pradesh who grows over 200 traditional varieties of rice and is also a renowned poet.') ??
                'An organic farmer from Madhya Pradesh who grows over 200 traditional varieties of rice and is also a renowned poet.',
          ),
          FarmerCard(
            name:
                localizations?.translate('Vallabhbhai Vasrambhai Marvaniya') ??
                    'Vallabhbhai Vasrambhai Marvaniya',
            story: localizations?.translate(
                    'A 97-year-old farmer from Gujarat who introduced carrots to local diets and developed high-yielding varieties.') ??
                'A 97-year-old farmer from Gujarat who introduced carrots to local diets and developed high-yielding varieties.',
          ),
          FarmerCard(
            name: localizations?.translate('Kanwal Singh Chauhan') ??
                'Kanwal Singh Chauhan',
            story: localizations?.translate(
                    'A farmer from Haryana who successfully cultivates baby corn and has helped over 5,000 farmers improve their yields.') ??
                'A farmer from Haryana who successfully cultivates baby corn and has helped over 5,000 farmers improve their yields.',
          ),
          FarmerCard(
            name:
                localizations?.translate('Kamala Pujhari') ?? 'Kamala Pujhari',
            story: localizations?.translate(
                    'A tribal agricultural activist from Odisha known for preserving traditional paddy varieties and promoting organic farming.') ??
                'A tribal agricultural activist from Odisha known for preserving traditional paddy varieties and promoting organic farming.',
          ),
          FarmerCard(
            name: localizations?.translate('Jagdish Prasad Parikh') ??
                'Jagdish Prasad Parikh',
            story: localizations?.translate(
                    'A farmer from Rajasthan who holds a record for growing one of the largest cauliflowers in the world.') ??
                'A farmer from Rajasthan who holds a record for growing one of the largest cauliflowers in the world.',
          ),
          FarmerCard(
            name: localizations?.translate('Hukumchand Patidar') ??
                'Hukumchand Patidar',
            story: localizations?.translate(
                    'An organic farmer from Rajasthan who transformed his farm into a model for organic practices and exports produce internationally.') ??
                'An organic farmer from Rajasthan who transformed his farm into a model for organic practices and exports produce internationally.',
          ),
          FarmerCard(
            name: localizations?.translate('Bharat Bhushan Tyagi') ??
                'Bharat Bhushan Tyagi',
            story: localizations?.translate(
                    'A science graduate who returned to his village in Uttar Pradesh to promote organic farming and educate over 100,000 farmers.') ??
                'A science graduate who returned to his village in Uttar Pradesh to promote organic farming and educate over 100,000 farmers.',
          ),
          FarmerCard(
            name: localizations?.translate('Ram Saran Verma') ??
                'Ram Saran Verma',
            story: localizations?.translate(
                    'Known as UPs "hi-tech farmer," he introduced tissue culture for banana farming and significantly increased his family\'s income.') ??
                'Known as UPs "hi-tech farmer," he introduced tissue culture for banana farming and significantly increased his family\'s income.',
          ),
          FarmerCard(
            name: localizations?.translate('Subhash Palekar') ??
                'Subhash Palekar',
            story: localizations?.translate(
                    'A pioneer of natural farming in India, he developed the Zero Budget Natural Farming method to reduce costs and improve yields.') ??
                'A pioneer of natural farming in India, he developed the Zero Budget Natural Farming method to reduce costs and improve yields.',
          ),
        ],
      ),
    );
  }
}

class FarmerCard extends StatelessWidget {
  final String name;
  final String story;

  const FarmerCard({required this.name, required this.story});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              story,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageSelectionDialog extends StatelessWidget {
  final Function(String) onLanguageSelected;

  LanguageSelectionDialog({required this.onLanguageSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              onLanguageSelected('en');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('हिंदी'),
            onTap: () {
              onLanguageSelected('hi');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('मराठी'),
            onTap: () {
              onLanguageSelected('mr');
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}