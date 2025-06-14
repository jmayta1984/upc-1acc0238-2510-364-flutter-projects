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
  /*final List<String> _genders = ["All", "Women", "Men", "Kids"];
  String _selectedGender = "All";
 */
  /*
  List<Shoe> _shoes = [];
  List<Shoe> _filteredShoes = [];
*/
  final TextEditingController _search = TextEditingController();

  /*
  void _onChangedText() {
    final query = _search.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredShoes = _shoes;
      } else {
        _filteredShoes = _shoes
            .where((shoe) => shoe.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }
*/
  /*
  Future loadData() async {
    final List<Shoe> shoes = await ShoeRepository().getShoes();

    setState(() {
      _shoes = shoes;
      _filteredShoes = _shoes;
    });
  }
*/
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
              //  onChanged: (_) => _onChangedText(),
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
/*
          SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: _genders.length,
              padding: EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final String gender = _genders[index];
                final bool isSelected = gender == _selectedGender;
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedGender = gender;
                    /*   if (gender.toLowerCase() == 'all') {
                      _filteredShoes = _shoes;
                    } else {
                      _filteredShoes = _shoes
                          .where(
                            (shoe) =>
                                shoe.gender.toLowerCase() ==
                                gender.toLowerCase(),
                          )
                          .toList();
                    }
                    */
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
                          _genders[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
*/
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
