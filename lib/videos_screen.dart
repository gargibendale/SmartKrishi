import 'package:flutter/material.dart';

class YouTubeLinksScreen extends StatelessWidget {
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
    String imagePath;
    switch (title) {
      case 'Crop Selection':
        imagePath = 'assets/images/crop_selection.jpg';
        break;
      case 'Pesticide Side Effects':
        imagePath = 'assets/images/pesticide_side_effects.jpg';
        break;
      case 'Agricultural Techniques':
        imagePath = 'assets/images/agricultural_techniques.jpg';
        break;
      case 'Fertilizers':
        imagePath = 'assets/images/fertilizers.jpg';
        break;
      default:
        imagePath = 'assets/images/default.jpg'; // Default image if no match
    }

    return InkWell(
      onTap: () => _onContainerTapped(context, title),
      child: Container(
        padding: EdgeInsets.all(16),
        // ... existing code ...
      ),
    );
  }

  // Function to navigate to different pages based on the container tapped
  void _onContainerTapped(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YouTubeLinksScreen(title: title),
      ),
    );
  }
}
