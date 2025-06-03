import 'package:demo/domain/shoe.dart';
import 'package:flutter/material.dart';

class ShoeDetailPage extends StatelessWidget {
  const ShoeDetailPage({super.key, required this.shoe});
  final Shoe shoe;

  @override
  Widget build(BuildContext context) {
    final List<ShoeSize> _sizes = shoe.sizes;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 400,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(shoe.image),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(shoe.name, style: TextStyle(fontSize: 24)),
              Text(shoe.brand),

              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sizes.length,
                  itemBuilder: (context, index) =>
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Text(_sizes[index].size.toString())),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
