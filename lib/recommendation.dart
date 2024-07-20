import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecommendationPage extends StatefulWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Recommendation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nController,
                decoration: InputDecoration(labelText: 'Nitrogen (N)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Nitrogen value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pController,
                decoration: InputDecoration(labelText: 'Phosphorus (P)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phosphorus value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kController,
                decoration: InputDecoration(labelText: 'Potassium (K)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Potassium value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _temperatureController,
                decoration: InputDecoration(labelText: 'Temperature (°C)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Temperature value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _humidityController,
                decoration: InputDecoration(labelText: 'Humidity (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Humidity value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phController,
                decoration: InputDecoration(labelText: 'pH'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pH value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rainfallController,
                decoration: InputDecoration(labelText: 'Rainfall (mm)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Rainfall value';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getRecommendation,
                child: Text('Get Recommendation'),
              ),
              SizedBox(height: 20),
              Text(
                _recommendedCrop.isEmpty
                    ? 'No recommendation yet'
                    : 'Recommended Crop: $_recommendedCrop',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
