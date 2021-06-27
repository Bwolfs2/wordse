import 'package:flutter/cupertino.dart';
import 'package:wordse_app/src/store/store_controller.dart';
import 'package:wordse_app/src/store/words_store.dart';

class FavoritesController {
  ValueNotifier<List<Words>> list = ValueNotifier([]);
  ValueNotifier<bool> loading = ValueNotifier<bool>(true);

  StoreController _storeController = StoreController();

//singleton
  static FavoritesController? _instance;
  static FavoritesController get getInstance => _instance ??= FavoritesController._();
  FavoritesController._() {
    getFavorites();
  }
  factory FavoritesController() => getInstance;
//singleton

  Future getFavorites() async {
    list.value = [];
    loading.value = true;
    var value = await _storeController.getFavorite();
    loading.value = false;
    list.value = value;
  }

  Future update(int id, int fav) async {
    await _storeController.update(id, fav);
    getFavorites();
  }
}
