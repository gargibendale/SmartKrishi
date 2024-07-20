import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../localizations/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? dateFormat = AppLocalizations.of(context)!.translate('date_format');
    String formattedDate = DateFormat(dateFormat).format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('title')!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.translate('welcome_message')!),
            SizedBox(height: 20),
            Text('Current Date: $formattedDate'),
          ],
        ),
      ),
    );
  }
}
