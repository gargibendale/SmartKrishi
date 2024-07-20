import 'package:flutter/material.dart';

class GreatFarmersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feats of Great Farmers'),
      ),
      body: ListView(
        children: [
          FarmerCard(
            name: 'George Washington Carver',
            story:
                'George Washington Carver was an American agricultural scientist and inventor who promoted alternative crops to cotton and methods to prevent soil depletion. He is best known for his work with peanuts, sweet potatoes, and soybeans, which helped improve the livelihoods of many farmers in the South.',
          ),
          FarmerCard(
            name: 'Norman Borlaug',
            story:
                'Norman Borlaug was an American agronomist and humanitarian who is often called the "father of the Green Revolution." His work in developing high-yielding varieties of wheat and promoting modern agricultural practices helped save over a billion people from starvation.',
          ),
          FarmerCard(
            name: 'Wangari Maathai',
            story:
                'Wangari Maathai was a Kenyan environmental activist and the first African woman to receive the Nobel Peace Prize. She founded the Green Belt Movement, which focused on tree planting, environmental conservation, and women’s rights, significantly impacting sustainable farming practices in Kenya.',
          ),
          // Add more FarmerCard widgets as needed
        ],
      ),
    );
  }
}

class FarmerCard extends StatelessWidget {
  final String name;
  final String story;

  const FarmerCard({required this.name, required this.story});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              story,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
