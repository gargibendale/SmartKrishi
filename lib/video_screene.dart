import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeLinksScreen extends StatelessWidget {
  final Map<String, List<Map<String, String>>> exercises = {
    'Crop Selection based on the climate': [
      {
        'title': 'Crop selection and Management',
        'url':
            'https://www.youtube.com/watch?v=iPEp1UO0pIM&pp=ygUiY3JvcCBzZWxlY3Rpb24gYWNjb3JpbmcgdG8gY2xpbWF0ZQ%3D%3D',
      },
      {
        'title': 'Crop selection for beginner farmers',
        'url':
            'https://www.youtube.com/watch?v=2oqo8Z-VGAA&pp=ygUiY3JvcCBzZWxlY3Rpb24gYWNjb3JpbmcgdG8gY2xpbWF0ZQ%3D%3D',
      },
      {
        'title': 'Crop planning for climate change',
        'url':
            'https://www.youtube.com/watch?v=ozohfNVhv5g&pp=ygUiY3JvcCBzZWxlY3Rpb24gYWNjb3JpbmcgdG8gY2xpbWF0ZQ%3D%3D',
      }
    ],
    'Pesticide Side-effects on crops as well as farmer': [
      {
        'title': 'The dangers of pesticides',
        'url':
            'https://www.youtube.com/watch?v=e9UU45pt4Q8&pp=ygUVcGVzdGljaWRlIHNpZGVlZmZlY3Rz',
      },
      {
        'title': 'What are pesticides, advantages and disadvantages',
        'url':
            'https://i.ytimg.com/an_webp/lJEeGMMcYCI/mqdefault_6s.webp?du=3000&sqp=CNL67bQG&rs=AOn4CLD-VXD296Mw9bvhwW_92nnopRIMHQ',
      },
      {
        'title': 'Side effects on pesticides on farmers health',
        'url':
            'https://www.youtube.com/watch?v=N4mVsYaMGTY&pp=ygUVcGVzdGljaWRlIHNpZGVlZmZlY3Rz',
      },
    ],
    'Fertilizers basics and usage': [
      {
        'title': 'Learning basics of Fertilizers',
        'url':
            'https://www.youtube.com/watch?v=WCD6iOQuetw&pp=ygUSdXNlIG9mIGZlcnRpbGl6ZXJz',
      },
      {
        'title': 'Understanding Fertilizers',
        'url':
            'https://www.youtube.com/watch?v=ZH6-MUY3yug&pp=ygUSdXNlIG9mIGZlcnRpbGl6ZXJz',
      },
      {
        'title': 'Organic Fertilizers',
        'url':
            'https://www.youtube.com/watch?v=NcMUOCU-R7I&pp=ygUSdXNlIG9mIGZlcnRpbGl6ZXJz',
      },
    ],
  };

  Future<void> _launchUrl(String url) async {
    try {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agriculture Techniques and Basics'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: exercises.keys.length,
          itemBuilder: (context, index) {
            String category = exercises.keys.elementAt(index);
            List<Map<String, String>> videos = exercises[category]!;
            return ExpansionTile(
              title: Text(
                category,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              children: videos.map((video) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: InkWell(
                    onTap: () => _launchUrl(video['url']!),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              video['title']!,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
