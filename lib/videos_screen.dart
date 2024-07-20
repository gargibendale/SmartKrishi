import 'package:flutter/material.dart';

class YouTubeLinksScreen extends StatelessWidget {
  // Function to navigate to different pages based on the container tapped
  void _onContainerTapped(BuildContext context, String title) {
    // Implement navigation or any other action here
    // For example, using Navigator.push to navigate to a different screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agricultural Information'),
      ),
      body: ListView(
        children: <Widget>[
          _buildInfoContainer(context, 'Crop Selection'),
          _buildInfoContainer(context, 'Pesticide Side Effects'),
          _buildInfoContainer(context, 'Agricultural Techniques'),
          _buildInfoContainer(context, 'Fertilizers'),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(BuildContext context, String title) {
    return InkWell(
      onTap: () => _onContainerTapped(context, title),
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

// Example of a details page that can be navigated to from the info containers
class DetailsPage extends StatelessWidget {
  final String title;

  DetailsPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Details for $title',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: YouTubeLinksScreen(),
  ));
}
