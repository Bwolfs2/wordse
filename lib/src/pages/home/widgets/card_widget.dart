import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/config/configs.dart';
import 'package:wordse_app/src/pages/details_page/details_page.dart';
import 'package:wordse_app/src/pages/home/widgets/list_card_page/list_controller.dart';
import 'package:wordse_app/store/store_controller.dart';
import 'package:wordse_app/store/words_store.dart';

class CardWords extends StatefulWidget {
  final Words? word;
  CardWords({Key? key, required this.word}) : super(key: key);

  @override
  _CardWordsState createState() => _CardWordsState();
}

class _CardWordsState extends State<CardWords> {
  @override
  Widget build(BuildContext context) {

    final cfg = Config();
    StoreController _storeController = StoreController();

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
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
                  Text("${widget.word?.wordEnglish} ",
                      style: GoogleFonts.montserrat(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("(${widget.word?.wordPortuguese})", style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.normal)),
                ],),
                SizedBox(height: 15,),
                Text("Example:", style: GoogleFonts.montserrat(color: cfg.subtitle, fontSize: 12, fontWeight: FontWeight.normal)),
                Text("${widget.word?.definition}", style: GoogleFonts.montserrat(color: cfg.subtitle, fontSize: 12, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          Flexible(
            flex: 0,
            child: Column(
              children: [
                IconButton(
                  onPressed: () async {
                    print(widget.word?.id);
                    if(widget.word?.favorite == 1) {
                          _storeController.update(widget.word?.id as int, 0).then((data) async {
                            setState(() {
                              widget.word?.favorite = 1;
                            });
                          });

                    } else {
                      _storeController.update(widget.word?.id as int, 1).then((data) async {
                        setState(() {
                          widget.word?.favorite = 2;
                        });
                      });
                    }
                }, icon: Icon(widget.word?.favorite == 1 ? Icons.favorite : Icons.favorite_border, color: Colors.red),),
                IconButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(words: widget.word)));
                }, icon: Icon(Icons.subdirectory_arrow_right, color: cfg.infoText),)
              ],
            ),
          )
        ],
      )
    );
  }
}
