import 'package:agri/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: const [
            CustomAppBar(),
            Expanded(child: Body()), // Add Expanded here
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Make the whole Body scrollable
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Features",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          // Add the ProductServiceCards here
          ProductServiceCard(
            imageUrl: 'assets/crop.jpg',
            title: 'Crop Recommendation',
            description:
                'Recommendation about the type of crops to be cultivated which is best suited for the respective conditions',
            onTap: () {
              Navigator.pushNamed(context, '/recommend');
            },
          ),
          ProductServiceCard(
            imageUrl: 'assets/fertilizer.jpg',
            title: 'Fertilizer Prediction',
            description:
                'Recommendation about the type of fertilizer best suited for the particular soil and the recommended crop',
            onTap: () {
              // Navigate to fertilizer recommendation screen
            },
          ),
          ProductServiceCard(
            imageUrl: 'assets/disease.jpg',
            title: 'Crop Disease',
            description:
                'Predicting the name and causes of crop disease and suggestions to cure it',
            onTap: () {
              // Navigate to crop disease prediction screen
            },
          ),
          ProductServiceCard(
            imageUrl: 'assets/crop.jpg',
            title: 'Youtube Picks',
            description:
                'Various youtube links to useful advice in multiple languages',
            onTap: () {
              Navigator.pushNamed(context, '/youtubecontainers');
            },
          ),
          ProductServiceCard(
            imageUrl: 'assets/famous farmer.jpg',
            title: 'Famous Indian Farmers',
            description:
                'Indian personalities who helped shape the farming practices of India',
            onTap: () {
              Navigator.pushNamed(context, '/farmerfeats');
            },
          ),
          ProductServiceCard(
            imageUrl: 'assets/famous farmer.jpg',
            title: 'AI advisor',
            description: 'Get agriculture related advice anytime, anywhere',
            onTap: () {
              Navigator.pushNamed(context, '/chat');
            },
          ),
          // Add more ProductServiceCards if needed
        ],
      ),
    );
  }
}

class ProductServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onTap;

  const ProductServiceCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            Color.fromARGB(255, 19, 67, 5),
            Color.fromARGB(255, 33, 145, 13),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,\nGood Morning",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SearchTextField(),
        ],
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
          size: 26,
        ),
        suffixIcon: const Icon(
          Icons.mic,
          color: Colors.green,
          size: 26,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: "Search your topic",
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        isDense: true,
      ),
    );
  }
}
