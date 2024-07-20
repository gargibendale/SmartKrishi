import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeLinksScreenH extends StatelessWidget {
  final Map<String, List<Map<String, String>>> exercises = {
    'जलवायु के आधार पर फसल का चयन': [
      {
        'title': 'फसल चयन एवं प्रबंधन',
        'url':
            'https://www.youtube.com/watch?v=mvMpaJS7DFo&pp=ygUlY3JvcCBzZWxlY3Rpb24gYmFzZWQgb24gY2xpbWF0ZSBoaW5kaQ%3D%3D',
      },
      {
        'title': 'फसलों के प्रकार',
        'url':
            'https://www.youtube.com/watch?v=XqVw-iKzACk&pp=ygUlY3JvcCBzZWxlY3Rpb24gYmFzZWQgb24gY2xpbWF0ZSBoaW5kaQ%3D%3D',
      },
    ],
    'कीटनाशकों का फसलों के साथ-साथ किसानों पर भी दुष्प्रभाव': [
      {
        'title': 'कीटनाशकों के खतरे',
        'url':
            'https://www.youtube.com/watch?v=KoLVSAsaNcQ&pp=ygUbZGFuZ2VycyBvZiBwZXN0aWNpZGVzIGhpbmRp',
      },
      {
        'title': 'कीटनाशक क्या हैं, फायदे और नुकसान',
        'url':
            'https://www.youtube.com/watch?v=Vl5SWnk3zkc&pp=ygUbZGFuZ2VycyBvZiBwZXN0aWNpZGVzIGhpbmRp',
      },
      {
        'title': 'किसानों के स्वास्थ्य पर कीटनाशकों के दुष्प्रभाव',
        'url':
            'https://www.youtube.com/watch?v=7UTSHYsjJDA&pp=ygUbZGFuZ2VycyBvZiBwZXN0aWNpZGVzIGhpbmRp',
      },
    ],
    'उर्वरक की मूल बातें और उपयोग': [
      {
        'title': 'उर्वरकों की मूल बातें सीखना',
        'url':
            'https://www.youtube.com/watch?v=SVYQGPIbzNE&pp=ygUXZmVydGlsaXplcnMgZ3VpZGUgaGluZGk%3D',
      },
      {
        'title': 'उर्वरकों को समझना',
        'url':
            'https://www.youtube.com/watch?v=HgPt61uRs20&pp=ygUXZmVydGlsaXplcnMgZ3VpZGUgaGluZGk%3D',
      },
      {
        'title': 'जैविक उर्वरक',
        'url':
            'https://i.ytimg.com/vi/2qiNKen-rm0/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLD7_-7NSNVvvcU0v-Jd5lxV6WVfJw',
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
        title: Text('कृषि तकनीक और मूल बातें हिंदी में'),
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
