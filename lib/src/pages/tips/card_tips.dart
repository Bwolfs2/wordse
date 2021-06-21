import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardTips extends StatelessWidget {
  final String? title;
  final String? message;
  final Color color;
  const CardTips({Key? key, required this.title, required this.message, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(
          color: color,
          width: 3.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Text("$title", textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text("$message"),
        ],
      ),
    );
  }
}
