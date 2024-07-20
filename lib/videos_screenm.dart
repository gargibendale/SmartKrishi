import 'package:agri/video_screene.dart';
import 'package:agri/videos_screenh.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeLinksScreenM extends StatelessWidget {
  final Map<String, List<Map<String, String>>> exercises = {
    'हवामानावर आधारित पिकांची निवड': [
      {
        'title': 'पीक निवड आणि व्यवस्थापन',
        'url': 'https://youtu.be/lNH6xZurpHA?si=ssmcnE0eBwgPB_kH',
      },
      {
        'title': 'नवशिक्या शेतकऱ्यांसाठी पिकांची निवड',
        'url':
            'https://www.youtube.com/watch?v=HSnI5vOnnFQ&pp=ygUrY3JvcCBzZWxlY3Rpb24gYmFzZWQgb24gY2xpbWF0ZSBpbiAgbWFyYXRoaQ%3D%3D',
      },
    ],
    'कीटकनाशके पिकांवर तसेच शेतकऱ्यावर होणारे दुष्परिणाम': [
      {
        'title': 'कीटकनाशकांचे धोके',
        'url':
            'https://www.youtube.com/watch?v=EGOY1LC-vww&pp=ygUkaGFybSBjYXVzZWQgYnkgcGVzdGljaWRlIGluICBtYXJhdGhp',
      },
      {
        'title': 'कीटकनाशके काय आहेत, फायदे आणि तोटे',
        'url':
            'https://www.youtube.com/watch?v=WtVgH8uYyUA&pp=ygUkaGFybSBjYXVzZWQgYnkgcGVzdGljaWRlIGluICBtYXJhdGhp',
      },
    ],
    'खते मूलभूत आणि वापर': [
      {
        'title': 'खतांच्या मूलभूत गोष्टी शिकणे',
        'url':
            'https://www.youtube.com/watch?v=VngUsRXWUI8&pp=ygUdZmVydGlsaXplcnMgZ3VpZGUgaW4gIG1hcmF0aGk%3D',
      },
      {
        'title': 'खते समजून घेणे',
        'url':
            'https://www.youtube.com/watch?v=4mvw8B3uXAg&pp=ygUdZmVydGlsaXplcnMgZ3VpZGUgaW4gIG1hcmF0aGk%3D',
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

  void _changeLanguage(BuildContext context, String language) {
    if (language == 'Hindi') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => YoutubeLinksScreenH()),
      );
    } else if (language == 'English') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => YoutubeLinksScreen()),
      );
    } else {
      print('Language changed to $language');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('मराठीतील कृषी तंत्र आणि मूलभूत गोष्टी'),
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String choice) => _changeLanguage(context, choice),
            itemBuilder: (BuildContext context) {
              return {'English', 'Hindi', 'Marathi'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        color: Colors.yellow.shade50,
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
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              video['title']!,
                              style: TextStyle(color: Colors.black, fontWeight : FontWeight.bold),
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