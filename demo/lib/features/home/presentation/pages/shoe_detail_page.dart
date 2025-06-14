import 'package:demo/features/favorites/domain/entities/favorite_shoe.dart';
import 'package:demo/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:demo/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:demo/features/home/domain/entities/shoe.dart';
import 'package:demo/core/themes/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoeDetailPage extends StatefulWidget {
  const ShoeDetailPage({super.key, required this.shoe});
  final Shoe shoe;

  @override
  State<ShoeDetailPage> createState() => _ShoeDetailPageState();
}

class _ShoeDetailPageState extends State<ShoeDetailPage> {
  String _selectedSize = "";

  @override
  Widget build(BuildContext context) {
    final Shoe shoe = widget.shoe;
    final List<ShoeSize> sizes = shoe.sizes;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalette.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
          child: const Text("Add to cart"),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 400,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Hero(
                      tag: widget.shoe.id,
                      child: Image.network(widget.shoe.image),
                    ),
                    Positioned(
                      top: 60,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          context.read<FavoriteBloc>().add(
                            AddFavoriteEvent(
                              favorite: FavoriteShoe(
                                id: shoe.id,
                                name: shoe.name,
                                image: shoe.image,
                                price: shoe.price,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.favorite_border),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.shoe.name, style: TextStyle(fontSize: 24)),
              Text(widget.shoe.brand),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: sizes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final String size = sizes[index].size.toString();
                    final bool isSelected = size == _selectedSize;
                    return GestureDetector(
                      onTap: () => setState(() {
                        _selectedSize = size;
                      }),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? ColorPalette.primaryColor
                                  : Colors.black54,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: isSelected
                                ? ColorPalette.primaryColor
                                : Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              sizes[index].size.toString(),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
