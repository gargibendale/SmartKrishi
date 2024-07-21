import 'package:agri/chat.dart';
import 'package:agri/farmer_feats.dart' as farmer;
import 'package:agri/farmer_feats.dart';
import 'package:agri/fertilizer_prediction.dart';
import 'package:agri/lang_containers.dart';
import 'package:agri/localizations/app_localizations.dart';
import 'package:agri/recommendation.dart';
import 'package:agri/video_screene.dart';
import 'package:agri/videos_screenh.dart';
import 'package:agri/videos_screenm.dart';
import 'package:agri/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agri/language_selection.dart' as lang;

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  Locale _locale = Locale('en'); // Default locale

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

    // Trigger a rebuild of localization
    await AppLocalizations.delegate.load(_locale);
  }

  Future<void> _showLanguageSelectionDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return lang.LanguageSelectionDialog(
          onLanguageSelected: (String languageCode) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('selected_language', languageCode);

            setState(() {
              _locale = Locale(languageCode);
            });

            // Reload localization
            await AppLocalizations.delegate.load(_locale);
          },
          // Provide other required parameters if any
        );
      },
    );
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
        Locale('ta'),
      ],
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
         backgroundColor: Colors.yellow.shade50,
          body: Column(
            children: [
              CustomAppBar(
                onLanguageButtonPressed: _showLanguageSelectionDialog,
              ),
              Expanded(child: Body()),
            ],
          ),
        ),
      ),
      routes: {
        '/recommend': (context) => RecommendationPage(onLanguageChanged: (Locale value) {  },),
        '/youtubecontainers': (context) => LangContainers(),
        '/farmerfeats': (context) => farmerfeats(onLanguageChanged: (String ) {  },),
        '/fertilizer': (context) => PredictorScreen(),
        '/chat': (context) => ChatPage(),
        '/youtubeE': (context) => YoutubeLinksScreen(),
        '/youtubeM': (context) => YoutubeLinksScreenM(),
        '/youtubeH': (context) => YoutubeLinksScreenH(),
        '/weather': (context) => WeatherPage(),
      },
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations?.translate('products_services') ??
                      'Products & Services',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          ProductServiceCard(
            imageUrl: 'assets/crop.jpg',
            title: localizations?.translate('crop_recommendation') ??
                localizations?.translate('Crop Recommendation') ??
                '',
            description: localizations
                    ?.translate('crop_recommendation_description') ??
                localizations?.translate(
                    'Recommendation about the type of crops to be cultivated which is best suited for the respective conditions') ??
                '',
            onTap: () {
              Navigator.pushNamed(context, '/recommend');
            },
          ),
          ProductServiceCard(
            imageUrl: 'assets/fertilizer.jpg',
            title: localizations?.translate('fertilizer_prediction') ??
                localizations?.translate('Fertilizer Prediction') ??
                '',
            description: localizations
                    ?.translate('fertilizer_prediction_description') ??
                localizations?.translate(
                    'Recommendation about the type of fertilizer best suited for the particular soil and the recommended crop') ??
                '',
            onTap: () {
              Navigator.pushNamed(context, '/fertilizer');
            },
          ),
          ProductServiceCard(
            imageUrl: 'assets/disease.jpg',
            title: localizations?.translate('crop_disease') ?? 'Crop Disease',
            description: localizations?.translate('crop_disease_description') ??
                localizations?.translate(
                    'Predicting the name and causes of the crop disease and suggestions to cure it') ??
                '',
            onTap: () {
              Navigator.pushNamed(context, '/chat');
            },
          ),
          ProductServiceCard(
            imageUrl: 'assets/fertilizer.jpg',
            title: localizations?.translate('youtube_picks') ?? 'Youtube Picks',
            description: localizations
                    ?.translate('youtube_picks_description') ??
                localizations?.translate(
                    'Various youtube links to useful advice in multiple languages') ??
                '',
            onTap: () {
              Navigator.pushNamed(context, '/youtubecontainers');
            },
          ),
          ProductServiceCard(
            imageUrl: 'assets/famous farmer.jpg',
             title: localizations?.translate('Feats of Great Indian Farmers') ?? 'Feats of Great Indian Farmers',
            description: localizations
                    ?.translate('Feats of Great Indian Farmers Description') ??
                localizations?.translate(
                    'Indian personalities who helped shape the farming practices of India') ??
                '',
          
            onTap: () {
              Navigator.pushNamed(context, '/farmerfeats');
            },
          ),
          ProductServiceCard(
            imageUrl: 'assets/weather.jpg',
             title: localizations?.translate('weather Chat') ?? 'Weather Chat',
            description: localizations
                    ?.translate('Weather Chat') ??
                localizations?.translate(
                    'Know the weather and get recommendations as easily as talking to a friend.') ??
                '',
           
            onTap: () {
              Navigator.pushNamed(context, '/weather');
            },
          ),
          // Add more ProductServiceCards if needed
        ],
      ),
    );
  }
}

class ProductServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onTap;

  const ProductServiceCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final VoidCallback onLanguageButtonPressed;

  const CustomAppBar({Key? key, required this.onLanguageButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            Color.fromARGB(255, 19, 67, 5),
            Color.fromARGB(255, 33, 145, 13),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SmartKrishi",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white, // Set text color to white
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Welcome to SmartKrishi",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onLanguageButtonPressed,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "Change Language",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
