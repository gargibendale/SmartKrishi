import 'package:flutter/material.dart';
import 'api/api_service.dart';
import 'localizations/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PredictorScreen(),
      localizationsDelegates: [
        // Add localization delegates here
      ],
      supportedLocales: [
        Locale('en', ''), // English
        Locale('mr', ''), // Marathi
        Locale('hi', ''), // Hindi
      ],
    );
  }
}

class PredictorScreen extends StatefulWidget {
  @override
  _PredictorScreenState createState() => _PredictorScreenState();
}

class _PredictorScreenState extends State<PredictorScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();
  final TextEditingController moistureController = TextEditingController();
  final TextEditingController nitrogenController = TextEditingController();
  final TextEditingController potassiumController = TextEditingController();
  final TextEditingController phosphorousController = TextEditingController();

  String? selectedSoilType;
  String? selectedCropType;
  String prediction = '';
  Locale _locale = Locale('en');

  Map<String, int> soilDict = {
    'Loamy (1)': 1,
    'Sandy (2)': 2,
    'Clayey (3)': 3,
    'Black (4)': 4,
    'Red (5)': 5,
  };

  Map<String, int> cropDict = {
    'Sugarcane (1)': 1,
    'Cotton (2)': 2,
    'Millets (3)': 3,
    'Paddy (4)': 4,
    'Pulses (5)': 5,
    'Wheat (6)': 6,
    'Tobacco (7)': 7,
    'Barley (8)': 8,
    'Oil seeds (9)': 9,
    'Ground Nuts (10)': 10,
    'Maize (11)': 11,
  };

  void getPrediction() async {
    if (selectedSoilType == null || selectedCropType == null) {
      setState(() {
        prediction = 'Please select soil type and crop type.';
      });
      return;
    }

    Map<String, dynamic> data = {
      'Temperature': double.parse(temperatureController.text),
      'Humidity': double.parse(humidityController.text),
      'Moisture': double.parse(moistureController.text),
      'Soil Type': soilDict[selectedSoilType],
      'Crop Type': cropDict[selectedCropType],
      'Nitrogen': double.parse(nitrogenController.text),
      'Potassium': double.parse(potassiumController.text),
      'Phosphorous': double.parse(phosphorousController.text),
    };

    try {
      print('Sending data: $data');
      Map<String, dynamic> result = await apiService.predictFertilizer(data);
      print('Received result: $result');
      setState(() {
        prediction = result['prediction'].toString();
      });
      showPredictionDialog(result['prediction']);
    } catch (e) {
      setState(() {
        prediction = 'Error: $e';
      });
      print('Error in getPrediction: $e');
    }
  }

  void showPredictionDialog(String fertilizer) {
    String benefits;
    String measures;

    switch (fertilizer) {
      case 'Urea':
        benefits =
            '1. High nitrogen content (46%): Urea is one of the most concentrated nitrogenous fertilizers, essential for vegetative growth and green, leafy development in crops.\n'
            '2. Cost-effective: Urea is relatively inexpensive compared to other nitrogen sources.\n'
            '3. Versatile: Can be used on a wide range of crops.';
        measures = '1. Avoid direct contact with seeds.\n'
            '2. Incorporate into soil.\n'
            '3. Use during growing season.';
        break;
      case 'DAP':
        benefits =
            '1. Balanced nutrients: Contains both nitrogen (18%) and phosphorus (46%), promoting root development and early plant growth.\n'
            '2. Easy handling and storage: Less hygroscopic compared to other fertilizers.';
        measures = '1. Use as a starter fertilizer.\n'
            '2. Avoid over-application.';
        break;
      case '28-28':
        benefits =
            '1. Equal parts nitrogen and phosphorus (28% each), supporting both vegetative growth and root development.';
        measures = '1. Appropriate for initial and mid-growth stages.\n'
            '2. Conduct soil tests.';
        break;
      case '14-35-14':
        benefits =
            '1. High phosphorus content: Promotes strong root systems and early plant vigor, critical during the early growth stages.\n'
            '2. Balanced nitrogen and potassium: Supports overall plant health and stress resistance.';
        measures = '1. Use for root development.\n'
            '2. Monitor application rates.';
        break;
      case '20-20':
        benefits =
            '1. Balanced nutrients: Provides equal parts nitrogen and phosphorus (20% each), supporting overall plant health and growth.';
        measures = '1. Versatile application: Suitable for various crops and growth stages.\n'
            '2. Combine with potassium sources if needed.';
        break;
      case '17-17-17':
        benefits =
            '1. Equal parts of nitrogen, phosphorus, and potassium (17% each), providing a comprehensive nutrient profile for crops.';
        measures = '1. Broad-spectrum use: Ideal for use throughout the growing season.\n'
            '2. Soil testing: Regularly test soil to adjust fertilizer application as needed.';
        break;
      case '10-26-26':
        benefits =
            '1. High phosphorus and potassium: Supports root development and enhances fruit and flower production.\n'
            '2. Balanced with nitrogen: Provides adequate nitrogen for vegetative growth.';
        measures = '1. Apply at flowering and fruiting stages.\n'
            '2. Avoid excessive nitrogen.';
        break;
      default:
        benefits = 'Unknown fertilizer type.';
        measures = 'No measures available.';
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fertilizer Prediction'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Prediction: $fertilizer'),
                SizedBox(height: 10),
                Text('Benefits:'),
                Text(benefits),
                SizedBox(height: 10),
                Text('Measures:'),
                Text(measures),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: Colors.yellow.shade50,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(('title')),
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.yellow.shade50,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: temperatureController,
                decoration: InputDecoration(
                  labelText: localizations.translate('temperature'),
                  labelStyle: TextStyle(color: Colors.green.shade900),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green.shade900),
              ),
              TextField(
                controller: humidityController,
                decoration: InputDecoration(
                  labelText: localizations.translate('humidity'),
                  labelStyle: TextStyle(color: Colors.green.shade900),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green.shade900),
              ),
              TextField(
                controller: moistureController,
                decoration: InputDecoration(
                  labelText: localizations.translate('moisture'),
                  labelStyle: TextStyle(color: Colors.green.shade900),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green.shade900),
              ),
              DropdownButtonFormField<String>(
                value: selectedSoilType,
                items: soilDict.keys.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedSoilType = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: localizations.translate('soil_type'),
                  labelStyle: TextStyle(color: Colors.green.shade900),
                ),
                style: TextStyle(color: Colors.green.shade900),
              ),
              DropdownButtonFormField<String>(
                value: selectedCropType,
                items: cropDict.keys.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCropType = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: localizations.translate('crop_type'),
                  labelStyle: TextStyle(color: Colors.green.shade900),
                ),
                style: TextStyle(color: Colors.green.shade900),
              ),
              TextField(
                controller: nitrogenController,
                decoration: InputDecoration(
                  labelText: localizations.translate('nitrogen'),
                  labelStyle: TextStyle(color: Colors.green.shade900),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green.shade900),
              ),
              TextField(
                controller: potassiumController,
                decoration: InputDecoration(
                  labelText: localizations.translate('potassium'),
                  labelStyle: TextStyle(color: Colors.green.shade900),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green.shade900),
              ),
              TextField(
                controller: phosphorousController,
                decoration: InputDecoration(
                  labelText: localizations.translate('phosphorous'),
                  labelStyle: TextStyle(color: Colors.green.shade900),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green.shade900),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: getPrediction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade900,
                  foregroundColor: Colors.white,
                ),
                child: Text(('predict')),
              ),
              SizedBox(height: 20),
              // ignore: prefer_interpolation_to_compose_strings
              Text(localizations.translate('prediction')! + ': $prediction'),
            ],
          ),
        ),
      ),
    );
  }
}
