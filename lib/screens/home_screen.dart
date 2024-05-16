import 'package:anim_search/providers/data_provider.dart';
import 'package:anim_search/screens/anime_grid_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // function for getting data for home screen
  Future<void> getData() async {
    await Provider.of<DataProvider>(context, listen: false)
        .getHomeData();
  }

  void searchData(String query) {
    Provider.of<DataProvider>(context, listen: false).searchData(query);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchAppBar(
        colorOnScroll: Colors.white,
        liftOnScrollElevation: 0,
        elevation: 0,
        hideKeyboardOnDownScroll: true,
        title: Container(),
        hint: 'Search anime or manga',
        iconColor: Colors.blue,
        autocorrect: false,
        onFocusChanged: (isFocused) {
          if (!isFocused) {
            setState(() {
              getData();
            });
          }
        },
        leadingActions: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
                icon: Icon(
                  Icons.album_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                splashRadius: 25,
                onPressed: () {
                  setState(() {
                    // getting data
                    getData();
                  });
                }),
          ),
        ],
        onSubmitted: (query) {
          setState(() {
            searchData(query);
          });
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                child: AnimeGridPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
