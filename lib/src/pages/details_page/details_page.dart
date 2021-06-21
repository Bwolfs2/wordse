import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/config/configs.dart';
import 'package:wordse_app/store/words_store.dart';

class DetailsPage extends StatelessWidget {
  final Words? words;
  const DetailsPage({Key? key, required this.words}) : super(key: key);

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
        backgroundColor: cfg.background,
        title: Text("${words?.wordEnglish}", style: GoogleFonts.montserrat(color: cfg.title),),
      ),
      body: Center(
        child: Text("Details page"),
      ),
    );
  }
}
