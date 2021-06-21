import 'package:flutter/cupertino.dart';
import 'package:wordse_app/store/store_controller.dart';

class ListController {

  ValueNotifier list = ValueNotifier([]);
  ValueNotifier loading = ValueNotifier(true);
  final storeController = StoreController();

  ListController(){
    get();
  }

  Future get() async {
    storeController.get().then((value) {
      print(value);
      loading.value = false;
      list.value = value;
    });
  }

}