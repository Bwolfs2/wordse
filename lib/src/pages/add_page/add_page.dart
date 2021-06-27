import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/config/configs.dart';
import 'package:wordse_app/src/pages/add_page/add_controller.dart';
import 'package:wordse_app/src/pages/home/home.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final controller = AddController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final cfg = Config();
    final size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: cfg.infoText,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
          },),
        centerTitle: true,
        title: Text("Adicionar", style: GoogleFonts.montserrat(color: Colors.white),),
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
                  labelText: "write your word in portuguese",
                  labelStyle: GoogleFonts.montserrat(color: cfg.infoText),
                  suffixIcon: Icon(Icons.translate, color: cfg.infoText,)
                )
              ),

              SizedBox(height: 15,),
              ValueListenableBuilder(
                valueListenable: controller.loading,
                builder: (_, __, ___) {
                  return ElevatedButton(
                      onPressed: () async {
                        await controller.getTranslate(controller.wordPortuguese.text).then((value) => {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Palavra salva com sucesso!"), backgroundColor: Colors.green,
                            duration: Duration(seconds: 1),))
                        });
                        Future.delayed(Duration(seconds: 1)).then((value) => {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()))
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: cfg.title,
                        elevation: 8,
                        fixedSize: Size(size.width, 50),
                        textStyle: GoogleFonts.montserrat(fontSize: 18)
                      ),
                      child: controller.loading.value == true ?
                          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),) :
                          Text("Save (salvar)")
                  );
                }
              ),
              SizedBox(height: 30),
              ValueListenableBuilder(
                  valueListenable: controller.status,
                  builder: (_, value, ___){
                    return Center(
                        child: Text("$value", style: GoogleFonts.montserrat(fontSize: 16),)
                    );
                  }
              )
            ],
          ),
        ),
      )
    );
  }
}
