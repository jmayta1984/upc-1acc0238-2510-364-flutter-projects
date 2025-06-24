import 'package:demo/core/themes/color_palette.dart';
import 'package:demo/features/home/presentation/blocs/shoes_bloc.dart';
import 'package:demo/features/home/presentation/blocs/shoes_event.dart';
import 'package:demo/features/home/presentation/blocs/shoes_state.dart';
import 'package:demo/features/home/presentation/widgets/shoe_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ShoesBloc>().add(GetShoesEvent());
    //loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _search,
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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.black, ColorPalette.primaryColor],
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Get Your Special Sale",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "Up to 50%",
                          style: TextStyle(
                            color: ColorPalette.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: ColorPalette.primaryColor,
                          ),
                          onPressed: () {},
                          child: Text("Shop now"),
                        ),
                      ],
                    ),
                  ),

                  Expanded(child: Image.asset("assets/banner.png")),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ShoesBloc, ShoesState>(
              builder: (context, state) {
                if (state is LoadingShoesState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorPalette.primaryColor,
                    ),
                  );
                } else if (state is SuccessShoesState) {
                  return ShoeListView(shoes: state.shoes);
                } else if (state is FailureShoesState) {
                  return Center(child: Text(state.errorMessage));
                }
                return Center(child: Text('what?'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
