import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wordse_app/src/pages/home/widgets/list_card_page/list_controller.dart';

import '../card_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  late ListController controller;

  @override
  void initState() {
    super.initState();
    controller = ListController();

    controller.loading.addListener(() {
      print(controller.loading.value);
    });

    controller.list.addListener(() {
      if(controller.list.value != null || controller.list.value.length > 0){
        controller.loading.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: controller.list,
      builder: (_, __, ___){
        if(controller.loading.value == true){
          return Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
          );
        }
        if(controller.list.value.length == 0){
          return Center(
            child: Text("Nenhuma palavra encontra, \nadicione pelo ícone de +", textAlign: TextAlign.center,),
          );
        }
        return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: controller.list.value.length,
            itemBuilder: (context, index) {
              return CardWords(
                  word: controller.list.value[index],
              );
            }
        );
      },
    );
  }
}
