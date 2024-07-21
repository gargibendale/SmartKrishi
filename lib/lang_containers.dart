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
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LangWidget(displayText: "Struggling with farming techniques?\nClick here for recommended YouTube videos to help you grow!", route: '/youtubeE'),
            LangWidget(displayText: "खेती की पैदावार बढ़ाने में परेशानी हो रही है?\nजवाब के लिए यूट्यूब वीडियो देखें! यूट्यूब पर क्लिक करें!", route: '/youtubeH'),
            LangWidget(displayText: "शेतीच्या उत्पादनात वाढ करण्यासाठी अडचण येत आहे का?\nउत्तरासाठी यूट्यूब व्हिडिओ पाहा! येथे क्लिक करा!", route: '/youtubeM')
          ],
        ),
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
              color: Colors.green[200],
              borderRadius: BorderRadius.circular(15.0),
            ),
            height: 200,
            width: 400,
            child: Center(
              child: Text(
                displayText,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
