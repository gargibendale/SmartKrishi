import 'dart:ui';

import 'package:flutter/material.dart';

class LangContainers extends StatefulWidget {
  const LangContainers({super.key});

  @override
  State<LangContainers> createState() => _LangContainersState();
}

class _LangContainersState extends State<LangContainers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LangWidget(displayText: "English", route: '/youtubeE'),
          LangWidget(displayText: "Hindi", route: '/youtubeH'),
          LangWidget(displayText: "Marathi", route: '/youtubeM')
        ],
      ),
    );
  }
}

class LangWidget extends StatelessWidget {
  final String displayText;
  final String route;
  const LangWidget({super.key, required this.displayText, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 91, 211, 95),
              borderRadius: BorderRadius.circular(15.0),
            ),
            height: 200,
            width: 400,
            child: Center(child: Text(displayText)),
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
