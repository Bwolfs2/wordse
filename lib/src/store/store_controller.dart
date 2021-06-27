import 'package:wordse_app/src/store/words_store.dart';

class StoreController {
  WordsStore store = WordsStore();

  Future get() async {
    var x = await store.getAllWords();
    print("print do get store controller $x");
    return x;
  }

  Future getId(int id) async {
    var x = await store.getWord(id);
    print("print do getId store controller $x");
    return x;
  }

  Future getFavorite() async {
    var x = await store.getFavoritesWords();
    print("print do getFavorite store controller $x");
    return x;
  }

  Future insert(Words w) async {
    var x = await store.saveWord(w);
    print("print do insert store controller $x");
    return x;
  }

  Future update(int id, int fav) async {
    var x = await store.updateFavorite(id, fav);
    print("print do update store controller $x");
    return x;
  }

  Future delete(int id) async {
    var x = await store.deleteWord(id);
    print("print do delete store controller $x");
    return x;
  }
}