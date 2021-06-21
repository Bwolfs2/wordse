import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/config/configs.dart';
import 'package:wordse_app/src/pages/add_page/add_controller.dart';
import 'package:wordse_app/store/words_store.dart';

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
          child: ListView(
            children: [
              TextFormField(
                controller: controller.wordPortuguese,
                decoration: InputDecoration(
                  labelText: "write your word in portuguese"
                )
              ),
              SizedBox(height: 15,),
              TextFormField(
                  controller: controller.wordEnglish,
                  decoration: InputDecoration(
                      labelText: "write your word in English"
                  )
              ),
              SizedBox(height: 15,),
              TextFormField(
                  controller: controller.definition,
                  decoration: InputDecoration(
                      labelText: "write the definition"
                  )
              ),
              SizedBox(height: 15,),
              TextFormField(
                  controller: controller.partOfSpeech,
                  decoration: InputDecoration(
                      labelText: "write the part of speech"
                  )
              ),
              SizedBox(height: 15,),
              TextFormField(
                  controller: controller.jsonResponse,
                  decoration: InputDecoration(
                      labelText: "write the json"
                  )
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: () async {
                    Words w = Words();

                    w.wordPortuguese = controller.wordPortuguese.text;
                    w.wordEnglish = controller.wordEnglish.text;
                    w.definition = controller.definition.text;
                    w.partOfSpeech = controller.partOfSpeech.text;
                    w.jsonResponse = controller.jsonResponse.text;

                    await controller.save(w).then((value) => Navigator.of(context).pop());
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
