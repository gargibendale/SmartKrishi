import 'package:agri/Fertilizer_prediction.dart';
import 'package:agri/chat.dart';
import 'package:agri/farmer_feats.dart';
import 'package:agri/lang_containers.dart';
import 'package:agri/localizations/app_localizations.dart';
import 'package:agri/recommendation.dart';
import 'package:agri/video_screene.dart';
import 'package:agri/videos_screenh.dart';
import 'package:agri/videos_screenm.dart';
import 'package:agri/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'loginpage.dart';
import 'signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'featured_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBKf5UVLwE5tYNzJhf2gC_k4XzW_TX9V9o",
      appId: "1:500709313217:android:53cb0873fe86f8f2fba240",
      messagingSenderId: "500709313217",
      projectId: "agri-aad01",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/feature': (context) => FeaturedScreen(),
        '/signup': (context) => SignUpPage(),

        '/recommend': (context) => RecommendationPage(onLanguageChanged: (Locale value) {  },),
        '/youtubeE': (context) => YoutubeLinksScreen(),
        '/youtubeM': (context) => YoutubeLinksScreenM(),
        '/youtubeH': (context) => YoutubeLinksScreenH(),
        '/youtubecontainers': (context) => LangContainers(),
        '/farmerfeats': (context) => farmerfeats(onLanguageChanged: (String ) {  },),
        '/fertilizer': (context) => PredictorScreen(),
        '/chat': (context) => ChatPage(),
        '/weather': (context) => WeatherPage()
      },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
      ],
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _checkLanguageSelection();
  }

  Future<void> _checkLanguageSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = prefs.getString('selected_language');

    if (selectedLanguage == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Update the locale and navigate to FeaturedScreen
      Locale locale = Locale(selectedLanguage);
      await AppLocalizations.delegate.load(locale);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FeaturedScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}


