import 'package:flutter/material.dart';

class IndianFarmersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feats of Great Indian Farmers'),
      ),
      body: ListView(
        children: [
          FarmerCard(
            name: 'Rajkumari Devi (Kisan Chachi)',
            story:
                'Known for her work in organic farming and empowering women through self-help groups in Bihar.',
          ),
          FarmerCard(
            name: 'Babulal Dahiya',
            story:
                'An organic farmer from Madhya Pradesh who grows over 200 traditional varieties of rice and is also a renowned poet.',
          ),
          FarmerCard(
            name: 'Vallabhbhai Vasrambhai Marvaniya',
            story:
                'A 97-year-old farmer from Gujarat who introduced carrots to local diets and developed high-yielding varieties.',
          ),
          FarmerCard(
            name: 'Kanwal Singh Chauhan',
            story:
                'A farmer from Haryana who successfully cultivates baby corn and has helped over 5,000 farmers improve their yields.',
          ),
          FarmerCard(
            name: 'Kamala Pujhari',
            story:
                'A tribal agricultural activist from Odisha known for preserving traditional paddy varieties and promoting organic farming.',
          ),
          FarmerCard(
            name: 'Jagdish Prasad Parikh',
            story:
                'A farmer from Rajasthan who holds a record for growing one of the largest cauliflowers in the world.',
          ),
          FarmerCard(
            name: 'Hukumchand Patidar',
            story:
                'An organic farmer from Rajasthan who transformed his farm into a model for organic practices and exports produce internationally.',
          ),
          FarmerCard(
            name: 'Bharat Bhushan Tyagi',
            story:
                'A science graduate who returned to his village in Uttar Pradesh to promote organic farming and educate over 100,000 farmers.',
          ),
          FarmerCard(
            name: 'Ram Saran Verma',
            story:
                'Known as UPs "hi-tech farmer," he introduced tissue culture for banana farming and significantly increased his family\'s income.',
          ),
          FarmerCard(
            name: 'Subhash Palekar',
            story:
                'A pioneer of natural farming in India, he developed the Zero Budget Natural Farming method to reduce costs and improve yields.',
          ),
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
