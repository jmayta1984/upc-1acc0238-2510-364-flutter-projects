
import 'package:demo/color_palette.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Search",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorPalette.primaryColor),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Row(
              children: [
                Column(
                  children: [
                    Text("Get Your Special Sale")
                  ],
                ),

                Expanded(child: Image.asset("assets/banner.png"))
              ],
            )
        ],
      ),
    );
  }
}