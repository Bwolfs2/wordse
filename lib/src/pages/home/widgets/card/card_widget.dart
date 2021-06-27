import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/config/configs.dart';
import 'package:wordse_app/src/pages/details_page/details_page.dart';
import 'package:wordse_app/src/pages/favorites/favorites_controller.dart';
import 'package:wordse_app/src/store/store_controller.dart';
import 'package:wordse_app/src/store/words_store.dart';

import '../list_card_page/list_controller.dart';

class CardWords extends StatefulWidget {
  final Words? word;
  final String path;
  final Function(bool) onTap;
  const CardWords({Key? key, required this.word, required this.onTap, required this.path}) : super(key: key);

  @override
  _CardWordsState createState() => _CardWordsState();
}

class _CardWordsState extends State<CardWords> {
  var cfg = Config();
  StoreController _storeController = StoreController();
  late ValueNotifier<int> favoriteChange = ValueNotifier(widget.word!.favorite);
  AudioPlayer audioPlayer = AudioPlayer();

  playMusic() async {
    await audioPlayer.play("${widget.word!.speak}", isLocal: false);
  }

  var listController = ListController();
  var favoriteController = FavoritesController();
  Future<void> updateList() async {
    await listController.get();
    await favoriteController.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(3, 10), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("${widget.word?.wordEnglish} ", style: GoogleFonts.montserrat(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("(${widget.word?.wordPortuguese})", style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.normal)),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(170 / 179),
                        child: IconButton(
                          icon: Icon(
                            Icons.volume_up_rounded,
                            color: Color(0xFF5390D9),
                          ),
                          onPressed: () {
                            playMusic();
                          },
                        ),
                      )
                    ],
                  ),
                  Text("Example:", style: GoogleFonts.montserrat(color: cfg.subtitle, fontSize: 12, fontWeight: FontWeight.normal)),
                  SelectableText("${widget.word?.definition}", style: GoogleFonts.montserrat(color: cfg.subtitle, fontSize: 12, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic)),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Flexible(
              flex: 0,
              child: Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: favoriteChange,
                      builder: (_, __, ___) {
                        return IconButton(
                          onPressed: () async {
                            if (favoriteChange.value == 1) {
                              await _storeController.update(widget.word?.id as int, 0);
                              favoriteChange.value = 0;
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("A palavra ${widget.word?.wordEnglish} "
                                    "foi removida dos favoritos"),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.blue,
                              ));
                              widget.onTap(true);
                              await updateList();
                            } else {
                              if (widget.path == "fav") {
                                await favoriteController.update(widget.word?.id as int, 1);
                                favoriteChange.value = 1;
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("A palavra ${widget.word?.wordEnglish} "
                                      "foi adicionada aos favoritos"),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.green,
                                ));
                                widget.onTap(true);
                                updateList();
                              } else {
                                await listController.update(widget.word?.id as int, 1);
                                favoriteChange.value = 1;
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("A palavra ${widget.word?.wordEnglish} "
                                      "foi adicionada aos favoritos"),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.green,
                                ));

                                widget.onTap(true);
                                updateList();
                              }
                            }
                          },
                          icon: Icon(favoriteChange.value == 1 ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                        );
                      }),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(words: widget.word)));
                    },
                    icon: Icon(Icons.arrow_forward_sharp, color: cfg.infoText),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
