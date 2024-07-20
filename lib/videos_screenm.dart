import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeLinksScreenM extends StatelessWidget {
  final Map<String, List<Map<String, String>>> exercises = {
    'हवामानावर आधारित पिकांची निवड': [
      {
        'title': 'पीक निवड आणि व्यवस्थापन',
        'url':
            'httpshttps://www.youtube.com/watch?v=C34k9-vhit0&pp=ygUrY3JvcCBzZWxlY3Rpb24gYmFzZWQgb24gY2xpbWF0ZSBpbiAgbWFyYXRoaQ%3D%3D',
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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('मराठीतील कृषी तंत्र आणि मूलभूत गोष्टी'),
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
                    onTap: () => _launchURL(video['url']!),
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
