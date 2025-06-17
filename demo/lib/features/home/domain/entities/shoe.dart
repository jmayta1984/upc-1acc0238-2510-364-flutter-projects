class Shoe {
  int id;
  String name;
  String brand;
  String gender;
  int price;
  String image;
  String description;
  List<ShoeSize> sizes;

  Shoe({
    required this.id,
    required this.name,
    required this.gender,
    required this.brand,
    required this.price,
    required this.image,
    required this.description,
    required this.sizes
  });
}

class ShoeSize {
  final double size;
  final int stock;

  ShoeSize({required this.size, required this.stock});
}
