import 'package:flutter/cupertino.dart';
import 'package:wordse_app/src/store/store_controller.dart';

class FavoritesController {
  ValueNotifier list = ValueNotifier([]);
  ValueNotifier<bool> loading = ValueNotifier<bool>(true);

  StoreController _storeController = StoreController();

  FavoritesController(){
    getFavorites();
  }

  Future getFavorites() async {
    list.value = [];
    loading.value = true;
    _storeController.getFavorite().then((value) {
      loading.value = false;
      list.value = value;
    });
  }

  Future update(int id, int fav) async {
    await _storeController.update(id, fav);
  }

}