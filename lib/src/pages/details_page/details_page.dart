import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/config/configs.dart';
import 'package:wordse_app/src/pages/details_page/details_controller.dart';
import 'package:wordse_app/src/pages/home/home.dart';
import 'package:wordse_app/src/store/words_store.dart';

class DetailsPage extends StatefulWidget {
  final Words? words;
  const DetailsPage({Key? key, required this.words}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  var controller = DetailsController();

  @override
  Widget build(BuildContext context) {
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
        child: Text("${widget.words}"),
      ),
    );
  }
}
