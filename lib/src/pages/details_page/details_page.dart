import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/config/configs.dart';
import 'package:wordse_app/src/models/WordModel.dart';
import 'package:wordse_app/src/pages/details_page/details_controller.dart';
import 'package:wordse_app/src/pages/home/home.dart';
import 'package:wordse_app/src/store/words_store.dart';
import 'dart:convert';

class DetailsPage extends StatefulWidget {
  final Words? words;
  const DetailsPage({Key? key, required this.words}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  var controller = DetailsController();
  var wordModel;

  encodeJson(){
    var myJson = widget.words!.jsonResponse;
    var encodeData = json.encode(myJson);
    var x = json.decode(encodeData);
    wordModel = x;
    // var jsonObject = jsonDecode(jsonEncode(myJson));
    print(x);
    Map map = json.decode(x);
    print(map.runtimeType);

    // var x = jsonDecode(jsonEncode(jsonObject));
    // decodeJson(x);
    // print("encode json: $x");
    return json;
  }

  decodeJson(var data){
    var x = WordModel.fromJson(data);
    print("decode json: $x");
  }

  @override
  Widget build(BuildContext context) {

    var data = json.encode(widget.words?.jsonResponse);

    final cfg = Config();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: cfg.title),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        backgroundColor: cfg.infoText,
        centerTitle: true,
        title: Text("${widget.words?.wordEnglish} (${widget.words?.wordPortuguese})",
          style: GoogleFonts.montserrat(color: cfg.title, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: () async {
            int? id = widget.words?.id;
            int x = await controller.delete(id!);
            if(x == 1){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
            }
          }, icon: Icon(Icons.delete, color: cfg.title,))
        ],
      ),
      body: Center(
        child: SelectableText("$wordModel"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    encodeJson();
  }
}
