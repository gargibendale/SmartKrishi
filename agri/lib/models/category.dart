// category.dart
class Category {
  final String name;
  final String thumbnail;

  Category({
    required this.name,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'Crop',
    thumbnail: 'assets/images/s3.jpg',
  ),
  Category(
    name: 'Fertilizer',
    thumbnail: 'assets/images/s2.jpg',
  ),
  Category(
    name: 'Crop Disease',
    thumbnail: 'assets/images/s4.jpg',
  ),
];
