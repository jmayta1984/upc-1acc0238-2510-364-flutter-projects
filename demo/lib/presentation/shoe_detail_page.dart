import 'package:demo/domain/shoe.dart';
import 'package:demo/presentation/color_palette.dart';
import 'package:flutter/material.dart';

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
    final List<ShoeSize> sizes = widget.shoe.sizes;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 400,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.shoe.id,
                  child: Image.network(widget.shoe.image)),
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
