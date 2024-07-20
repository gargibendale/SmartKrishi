import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherService({required this.apiKey});

  Future<Map<String, dynamic>> getWeather(String city) async {
    final response = await http.get(
      Uri.parse('$apiUrl?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final weatherData = jsonDecode(response.body);
      final weatherDescription = weatherData['weather'][0]['description'];

      String? precaution = _getPrecaution(weatherDescription);

      return {
        'weather': weatherData['weather'],
        'main': weatherData['main'],
        'precaution': precaution,
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  String? _getPrecaution(String weatherDescription) {
    if (weatherDescription.contains('light rain')) {
      return 'Precaution: No Precaution';
    } else if (weatherDescription.contains('moderate rain')) {
      return 'Precaution: Ensure proper drainage in fields to prevent waterlogging and soil erosion. Secure loose items. '
          'Crops like tomatoes, beans, and leafy greens need careful monitoring for fungal infections during wet conditions.';
    } else if (weatherDescription.contains('heavy rain')) {
      return 'Precaution: Ensure proper drainage in fields to prevent waterlogging and soil erosion. Secure loose items. '
          'Check root crops like carrots, potatoes, and onions for signs of rot. Consider installing temporary covers to protect delicate plants.';
    } else if (weatherDescription.contains('mist')) {
      return 'Precaution: Avoid chemical sprays on crops during mist. Monitor crops for fungal growth. '
          'Crops such as strawberries, cucumbers, and spinach are susceptible to fungal diseases in misty conditions. Ensure good air circulation around plants.';
    } else if (weatherDescription.contains('overcast clouds')) {
      return 'Precaution: Ensure crops get enough light by spacing them out. Monitor for fungal growth. '
          'Plants like peppers, eggplants, and basil may suffer from reduced sunlight. Use reflective surfaces or grow lights to supplement natural light.';
    } else if (weatherDescription.contains('haze')) {
      return 'Precaution: Monitor air quality and avoid chemical sprays. Water crops adequately to reduce stress. '
          'Haze can affect photosynthesis in crops like corn, soybeans, and wheat. Keep the soil moist and mulched to help plants cope with stress.';
    } else {
      return null;
    }
  }
}