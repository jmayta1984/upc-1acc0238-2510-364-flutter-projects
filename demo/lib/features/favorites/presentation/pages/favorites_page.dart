import 'package:demo/features/favorites/domain/entities/favorite_shoe.dart';
import 'package:demo/features/favorites/presentation/widgets/favorite_shoe_list_view.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
   FavoritesPage({super.key});

  final List<FavoriteShoe> favorites = [
    FavoriteShoe(
      id: 1,
      name: "Nike Air Max",
      image: "https://images.novelship.com/product/1681910497692_adidasNMD_0.png",
      price: 120,
    ),
    FavoriteShoe(
      id: 2,
      name: "Adidas Ultraboost",
      image: "https://images.novelship.com/product/1681910497692_adidasNMD_0.png",
      price: 180,
    ),
    FavoriteShoe(
      id: 3,
      name: "Puma RS-X",
      image: "https://images.novelship.com/product/1681910497692_adidasNMD_0.png",
      price: 110,
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: FavoriteShoeListView(favorites: favorites),
    );
  }
}