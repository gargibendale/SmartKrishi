import 'package:agri/Fertilizer_prediction.dart';
import 'package:agri/farmer_feats.dart';
import 'package:agri/lang_containers.dart';
import 'package:agri/recommendation.dart';
import 'package:agri/video_screene.dart';
import 'package:agri/videos_screenh.dart';
import 'package:agri/videos_screenm.dart';
import 'package:flutter/material.dart';
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
        '/': (context) => PredictorScreen(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/recommend': (context) => RecommendationPage(),
        '/youtubeE': (context) => YoutubeLinksScreen(),
        '/youtubeM': (context) => YoutubeLinksScreenM(),
        '/youtubeH': (context) => YoutubeLinksScreenH(),
        '/youtubecontainers': (context) => LangContainers()
      },
    );
  }
}
