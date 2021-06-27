import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordse_app/src/pages/home/widgets/card/card_widget.dart';
import 'package:wordse_app/src/pages/home/widgets/list_card_page/list_controller.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  late ListController controller = ListController();

  @override
  void initState() {
    super.initState();
    controller.list.addListener(() {

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: controller.list,
      builder: (_, value, ___){
        if(controller.loading.value == true){
          return Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
          );
        }
        if(controller.list.value.length == 0){
          return Center(
            child: Text("Nenhuma palavra encontrada, \nadicione pelo ícone de +",
              textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 16),),
          );
        }
        return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: controller.list.value.length,
            itemBuilder: (context, index) {
              return CardWords(
                  word: controller.list.value[index],
                  path: "list",
                  onTap: (value) async {
                    // await controller.get();
                  },
              );
            }
        );
      },
    );
  }
}
