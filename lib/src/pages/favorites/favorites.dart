import 'package:flutter/material.dart';
import 'package:wordse_app/src/pages/home/widgets/card_widget.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      children: [
        // CardWords(word: 'Husband', wordPortuguese: 'Marido', phrase: 'a married man; a woman\'s partner in marriage', favorite: 1,),
        // CardWords(word: 'Accept', wordPortuguese: 'Aceitar', phrase: 'give an affirmative reply to; respond favorably to', favorite: 1,),
        // CardWords(word: 'Huge', wordPortuguese: 'Enorme', phrase: 'unusually great in size or amount or degree or especially extent or scope', favorite: 1,),
      ],
    );
  }
}
