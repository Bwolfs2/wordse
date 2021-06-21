import 'package:flutter/cupertino.dart';
import 'package:wordse_app/store/store_controller.dart';

class ListController {

  ValueNotifier list = ValueNotifier([]);
  ValueNotifier loading = ValueNotifier(true);
  final storeController = StoreController();

  ListController(){
    get().then((value) => loading.value = false);
  }

  Future get() async {
    list.value = [];
    loading.value = true;
    storeController.get().then((value) {
      print(value);
      loading.value = false;
      list.value = value;
    });
  }

}