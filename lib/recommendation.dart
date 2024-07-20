import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'localizations/app_localizations.dart';

class RecommendationPage extends StatefulWidget {
  final ValueChanged<Locale> onLanguageChanged;

  RecommendationPage({required this.onLanguageChanged});

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nController = TextEditingController();
  final _pController = TextEditingController();
  final _kController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _humidityController = TextEditingController();
  final _phController = TextEditingController();
  final _rainfallController = TextEditingController();

  String _recommendedCrop = '';

  Future<void> _getRecommendation() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse(
              'https://tightly-daring-killdeer.ngrok-free.app/api/recommend/'), // Adjust the URL as needed
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            'N': int.parse(_nController.text),
            'P': int.parse(_pController.text),
            'K': int.parse(_kController.text),
            'temperature': double.parse(_temperatureController.text),
            'humidity': double.parse(_humidityController.text),
            'ph': double.parse(_phController.text),
            'rainfall': double.parse(_rainfallController.text),
          }),
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          setState(() {
            _recommendedCrop = responseData['recommended_crop'];
          });
        } else {
          print('Failed to get recommendation: ${response.reasonPhrase}');
          setState(() {
            _recommendedCrop =
                'Failed to get recommendation: ${response.reasonPhrase}';
          });
        }
      } catch (e) {
        setState(() {
          _recommendedCrop = 'Failed to get recommendation: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _nController.dispose();
    _pController.dispose();
    _kController.dispose();
    _temperatureController.dispose();
    _humidityController.dispose();
    _phController.dispose();
    _rainfallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Recommendation'),
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow.shade50,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nController,
                decoration: InputDecoration(
                  labelText: localizations?.translate('nitrogen'),
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green[900]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations?.translate('enter_nitrogen');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pController,
                decoration: InputDecoration(
                  labelText: localizations?.translate('phosphorus'),
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green[900]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations?.translate('enter_phosphorus');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kController,
                decoration: InputDecoration(
                  labelText: localizations?.translate('potassium'),
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green[900]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations?.translate('enter_potassium');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _temperatureController,
                decoration: InputDecoration(
                  labelText: localizations?.translate('temperature'),
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green[900]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations?.translate('enter_temperature');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _humidityController,
                decoration: InputDecoration(
                  labelText: localizations?.translate('humidity'),
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green[900]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations?.translate('enter_humidity');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phController,
                decoration: InputDecoration(
                  labelText: localizations?.translate('ph'),
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green[900]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations?.translate('enter_ph');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rainfallController,
                decoration: InputDecoration(
                  labelText: localizations?.translate('rainfall'),
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green[900]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations?.translate('enter_rainfall');
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getRecommendation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[900], // Background color
                  foregroundColor: Colors.white, // Text color
                ),
                child: Text(localizations!.translate('get_recommendation')!),
              ),
              SizedBox(height: 20),
              Text(
                _recommendedCrop.isEmpty
                    ? localizations.translate('no_recommendation_yet')!
                    : '${localizations?.translate('recommended_crop')!} $_recommendedCrop',
                style: TextStyle(fontSize: 18),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
