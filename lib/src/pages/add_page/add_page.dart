import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/config/configs.dart';
import 'package:wordse_app/src/pages/add_page/add_controller.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final controller = AddController();

  @override
  Widget build(BuildContext context) {

    final cfg = Config();
    final _formKey = new GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: cfg.title), onPressed: () {Navigator.of(context).pop();},),
        backgroundColor: cfg.background,
        title: Text("Adicionar", style: GoogleFonts.montserrat(color: cfg.title),),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.wordController,
                decoration: InputDecoration(
                  labelText: "write your word in portuguese"
                )
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: cfg.title,
                  ),
                  child: Text("Save (salvar)")
              )
            ],
          ),
        ),
      )
    );
  }
}
