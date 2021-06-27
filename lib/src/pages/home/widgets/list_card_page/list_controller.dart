import 'package:flutter/cupertino.dart';
import 'package:wordse_app/src/store/store_controller.dart';
import 'package:wordse_app/src/store/words_store.dart';

class ListController {
  ValueNotifier<List<Words>> list = ValueNotifier([]);
  ValueNotifier loading = ValueNotifier(true);
  final storeController = StoreController();

//singleton
  static ListController? _instance;
  static ListController get getInstance => _instance ??= ListController._();
  ListController._() {
    get();
  }
  factory ListController() => getInstance;
//singleton

  Future get() async {
    list.value = [];
    var value = await storeController.get();
    list.value = value;
    loading.value = false;
  }

  Future update(int id, int fav) async {
    int x = await storeController.update(id, fav);

    if (x == 1) {
      await get();
    }
  }
}
