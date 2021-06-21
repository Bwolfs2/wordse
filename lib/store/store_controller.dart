import 'package:wordse_app/store/words_store.dart';

class StoreController {
  WordsStore store = WordsStore();

  Future get() async {
    return await store.getAllWords();
  }

  Future getId(int id) async {
    return await store.getWord(id);
  }

  Future getFavorite() async {
    return await store.getFavoritesWords();
  }

  Future insert(Words w) async {
    await store.saveWord(w);
  }

  Future update(int id, int fav) async {
    return store.updateFavorite(id, fav);
  }

  Future delete(int id) async {
    return store.deleteWord(id);
  }
}