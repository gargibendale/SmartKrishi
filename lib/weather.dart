import 'package:flutter/material.dart';
import 'weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _chatHistoryDisplay = [];
  late WeatherService _weatherService;

  @override
  void initState() {
    super.initState();
    _weatherService = WeatherService(apiKey: OPEN_WEATHER_API_KEY);
  }

  void _handleSendMessage() async {
    final message = _messageController.text;
    _messageController.clear();

    setState(() {
      _chatHistoryDisplay.add({'role': 'user', 'text': message});
    });

    try {
      final weatherData = await _weatherService.getWeather(message);
      final weatherDescription = weatherData['weather'][0]['description'];
      final temperature = weatherData['main']['temp'];
      final humidity = weatherData['main']['humidity'];
      final response =
          'Weather in $message: $weatherDescription, Temperature: $temperature°C, Humidity: $humidity%';

      print('Weather Data: $weatherData');
      print('Weather Description: $weatherDescription');

      setState(() {
        _chatHistoryDisplay.add({'role': 'model', 'text': response});
      });

      if (weatherData['precaution'] != null) {
        print(
            'Precaution: ${weatherData['precaution']}'); // Log the precaution message
        setState(() {
          _chatHistoryDisplay
              .add({'role': 'precaution', 'text': weatherData['precaution']!});
        });
      }
    } catch (e) {
      print('Error: $e'); // Log the error
      setState(() {
        _chatHistoryDisplay.add({'role': 'model', 'text': 'Error: $e'});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Chat'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                'assets/weather1.jpg', // Use Image.asset for local assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _chatHistoryDisplay.length,
                  itemBuilder: (context, index) {
                    final message = _chatHistoryDisplay[index]['text']!;
                    final isUserMessage =
                        _chatHistoryDisplay[index]['role'] == 'user';
                    final isPrecautionMessage =
                        _chatHistoryDisplay[index]['role'] == 'precaution';
                    return Row(
                      mainAxisAlignment: isUserMessage
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: isUserMessage
                                    ? Color.fromARGB(255, 255, 203, 204)
                                    : isPrecautionMessage
                                        ? Colors.yellow.shade100
                                        : const Color.fromARGB(
                                            255, 255, 255, 255),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              child: Text(
                                message,
                                style: TextStyle(
                                  color: isUserMessage
                                      ? const Color.fromARGB(255, 37, 21, 65)
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        controller: _messageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Type a city name...',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 14, 43, 86),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _handleSendMessage,
                      icon: const Icon(Icons.send),
                      color: const Color.fromARGB(255, 10, 50, 83),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const OPEN_WEATHER_API_KEY = "cf741afa178ba990be9e4cf9779fc49f";
