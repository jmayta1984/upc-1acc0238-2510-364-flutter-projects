import 'package:demo/core/themes/color_palette.dart';
import 'package:demo/features/favorites/domain/entities/favorite_shoe.dart';
import 'package:demo/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:demo/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:demo/features/home/presentation/blocs/shoes_bloc.dart';
import 'package:demo/features/home/presentation/blocs/shoes_event.dart';
import 'package:demo/features/home/presentation/blocs/shoes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteShoeListView extends StatefulWidget {
  const FavoriteShoeListView({super.key, required this.favorites});
  final List<FavoriteShoe> favorites;

  @override
  State<FavoriteShoeListView> createState() => _FavoriteShoeListViewState();
}

class _FavoriteShoeListViewState extends State<FavoriteShoeListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.favorites.length,
      itemBuilder: (context, index) {
        final favorite = widget.favorites[index];
        return Card(
          child: Row(
            children: [
              SizedBox(
                width: 120,
                height: 90,
                child: Image.network(favorite.image, fit: BoxFit.cover),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$ ${favorite.price}'),
                    Text(
                      favorite.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        context.read<ShoesBloc>().add(
                          GetShoeByIdEvent(id: favorite.id),
                        );
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            String selectedSize = "";

                            return StatefulBuilder(
                              builder: (context, setModalState) {
                                return SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          spacing: 10,
                                      children: [
                                        Text(
                                          'Sizes',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        BlocBuilder<ShoesBloc, ShoesState>(
                                          builder: (context, state) {
                                            if (state is LoadedShoeState) {
                                              List sizes = state.shoe.sizes;
                                              return SizedBox(
                                                height: 40,
                                                child: ListView.separated(
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          SizedBox(width: 10),
                                                  itemCount: sizes.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (context, index) {
                                                    final String size =
                                                        sizes[index].size
                                                            .toString();
                                                    final bool isSelected =
                                                        size == selectedSize;
                                                    return GestureDetector(
                                                      onTap: () =>
                                                          setModalState(() {
                                                            selectedSize = size;
                                                          }),
                                                      child: Center(
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: Colors
                                                                  .transparent,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            color: isSelected
                                                                ? ColorPalette
                                                                      .primaryColor
                                                                : Colors.white,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              sizes[index].size
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color:
                                                                    isSelected
                                                                    ? Colors
                                                                          .white
                                                                    : Colors
                                                                          .black54,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      color: ColorPalette
                                                          .primaryColor,
                                                    ),
                                              );
                                            }
                                          },
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorPalette.primaryColor,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: const Text("Add to cart"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Text('Add to cart'),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Options',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.shopping_cart_outlined),
                                title: Text('Add to cart'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.read<FavoriteBloc>().add(
                                    RemoveFavoriteEvent(id: favorite.id),
                                  );
                                  Navigator.pop(context);
                                },
                                child: ListTile(
                                  leading: Icon(Icons.delete_outline_outlined),
                                  title: Text('Remove from favorites'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
        );
      },
    );
  }
}
