import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/pages/favorites/favorites_controller.dart';
import 'package:wordse_app/src/pages/home/widgets/card_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritesController controller;


  @override
  void initState() {
    super.initState();
    controller = FavoritesController();
  }

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: controller.list,
      builder: (_, __, ___){
        if(controller.loading.value == true){
          return Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
          );
        }
        if(controller.list.value.length == 0){
          return Center(
            child: Text("Nenhuma palavra adicionada aos favoritos.", textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 16)),
          );
        }
        return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: controller.list.value.length,
            itemBuilder: (context, index) {
              return CardWords(
                word: controller.list.value[index],
                path: "fav",
                onTap: (value){
                  controller.getFavorites();
                },
              );
            }
        );
      },
    );
  }
}
