import 'package:demo/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:demo/features/auth/presentation/blocs/auth_state.dart';
import 'package:demo/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:demo/features/cart/presentation/blocs/cart_event.dart';
import 'package:demo/features/favorites/domain/entities/favorite_shoe.dart';
import 'package:demo/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:demo/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:demo/features/favorites/presentation/blocs/favorite_state.dart';
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
  void initState() {
    context.read<FavoriteBloc>().add(IsFavoriteEvent(id: widget.shoe.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Shoe shoe = widget.shoe;
    final List<ShoeSize> sizes = shoe.sizes;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorPalette.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: _selectedSize.isEmpty
                ? null
                : () {
                    context.read<CartBloc>().add(
                      AddToCartEvent(
                        shoeId: shoe.id,
                        name: shoe.name,
                        price: shoe.price,
                        size: double.parse(_selectedSize),
                        quantity: 1,
                        username:
                            (context.read<AuthBloc>().state as SuccessAuthState)
                                .user
                                .username,
                        image: shoe.image,
                      ),
                    );
                  },
            child: const Text("Add to cart"),
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              primary: false,
              expandedHeight: 300,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Hero(
                          tag: shoe.id,
                          child: Image.network(shoe.image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          context.read<FavoriteBloc>().add(
                            OnToggleFavoriteEvent(
                              favorite: FavoriteShoe(
                                id: shoe.id,
                                name: shoe.name,
                                image: shoe.image,
                                price: shoe.price,
                              ),
                            ),
                          );
                        },
                        icon: BlocBuilder<FavoriteBloc, FavoriteState>(
                          builder: (context, state) {
                            if (state is IsFavoriteState) {
                              return Icon(
                                state.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                              );
                            }
                            return Icon(Icons.favorite_border);
                          },
                        ),
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
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.shoe.name,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$ ${widget.shoe.price}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(widget.shoe.brand, style: TextStyle(color: Colors.grey)),
              Text(widget.shoe.description),
              Text(
                'Sizes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 40,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: sizes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final String size = sizes[index].size.toString();
                    final bool isSelected = size == _selectedSize;
                    return GestureDetector(
                      onTap: () => setState(() {
                        _selectedSize = size;
                      }),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                            color: isSelected
                                ? ColorPalette.primaryColor
                                : Colors.white,
                          ),
                          child: Center(
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
