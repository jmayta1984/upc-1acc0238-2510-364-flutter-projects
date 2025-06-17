import 'package:demo/features/home/domain/entities/shoe.dart';
import 'package:demo/features/home/presentation/pages/shoe_detail_page.dart';
import 'package:flutter/material.dart';

class ShoeListView extends StatelessWidget {
  final List<Shoe> shoes;

  const ShoeListView({super.key, required this.shoes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: shoes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final Shoe shoe = shoes[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoeDetailPage(shoe: shoe),
              ),
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 120,
                        height: 90,
                        child: Hero(
                          tag: shoe.id,
                          child: Image.network(shoe.image, fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '\$ ${shoe.price}',

                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    shoe.name,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(shoe.brand),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
