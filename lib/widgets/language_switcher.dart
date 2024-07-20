// import 'package:agri/screens/home_screen.dart';
// import 'package:flutter/material.dart';
// import '../main.dart';
// import '../localizations/app_localizations.dart';

// class LanguageSwitcher extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(AppLocalizations.of(context)!.translate('choose_language')!),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             title: Text('English'),
//             onTap: () {
//               MyApp.setLocale(context, Locale('en', 'US'));
//               Navigator.of(context).pop();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => HomeScreen()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('हिन्दी'),
//             onTap: () {
//               MyApp.setLocale(context, Locale('hi', 'IN'));
//               Navigator.of(context).pop();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => HomeScreen()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('मराठी'),
//             onTap: () {
//               MyApp.setLocale(context, Locale('mr', 'IN'));
//               Navigator.of(context).pop();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => HomeScreen()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('தமிழ்'),
//             onTap: () {
//               MyApp.setLocale(context, Locale('ta', 'IN'));
//               Navigator.of(context).pop();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => HomeScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
