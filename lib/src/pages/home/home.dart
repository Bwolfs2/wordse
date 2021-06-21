import 'package:flutter/material.dart';
import 'package:wordse_app/src/config/configs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/pages/add_page/add_page.dart';
import 'package:wordse_app/src/pages/favorites/favorites.dart';
import 'package:wordse_app/src/pages/settings/settings.dart';
import 'package:wordse_app/src/pages/tips/tips.dart';
import 'package:wordse_app/store/words_store.dart';

import 'home_controller.dart';
import 'widgets/list_card_page/list_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Config cfg = new Config();
  final controller = HomeController();
  final pageController = PageController(initialPage: 0);
  final scrollViewController = ScrollController ();
  WordsStore store = WordsStore();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ListPage(),
      TipsPage(),
      FavoritesPage(),
      SettingsPage()
    ];

    return Scaffold(
      backgroundColor: cfg.background,
      body: NestedScrollView(
         controller: scrollViewController,
        headerSliverBuilder: (_, __){
           return <Widget>[
              SliverAppBar(
                backgroundColor: cfg.background,
                floating: true,
                actions: [
                  IconButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPage()));
                  }, icon: Icon(Icons.add, color: cfg.title))
                ],
                title: Text("Hi! Nice to see you!",
                style: GoogleFonts.montserrat(
                color: cfg.title,
                fontWeight: FontWeight.w400,
              ),),
            )
           ];
        },
        body: PageView(
            onPageChanged: (i){
              controller.index = i;
            },
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: pages
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: controller.valueIndex,
        builder: (_, __, ___){
          return BottomNavigationBar(
            backgroundColor: cfg.background,
            currentIndex: controller.index,
            selectedItemColor: cfg.title,
            unselectedItemColor: Colors.grey,
            onTap: (i){
              controller.index = i;
              pageController.animateToPage(
                  controller.index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "Dicas"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoritos"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Configurações"),
            ],
          );
        },
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
