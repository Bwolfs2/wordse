import 'dart:convert';

import 'package:wordse_app/src/pages/add_page/translation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wordse_app/src/store/store_controller.dart';
import 'package:wordse_app/src/store/words_store.dart';

class AddController {
  final storeController = StoreController();
  TranslationApi _translationApi = TranslationApi();
  TextEditingController wordPortuguese = TextEditingController();
  final status = ValueNotifier<String>("");
  final loading = ValueNotifier<bool>(false);

  Future getTranslate(String ptWord) async {
    print('iniciei o getTranslate');
    status.value = "Traduzindo a palavra...";
    loading.value = true;
    await _translationApi.translate(ptWord).then((value) async {
      print("valor da tradução: $value");
      await getWordData(ptWord, value);
    });
  }

  Future getWordData(String ptWord, String enWord) async {
      print('iniciei o getWordData');
      status.value = "procurando as informações da palavra...";
      final url = "https://api.dictionaryapi.dev/api/v2/entries/en_US/$enWord";

      try {
        final response = await http.get(Uri.parse(url));

        if(response.statusCode == 200) {
          final body = json.decode(response.body);
          print("response body da api de palavra: \n$body");

          Words w = Words();
          w.wordPortuguese = ptWord;
          w.wordEnglish = enWord;
          w.speak = body[0]['phonetics'][0]['audio'].toString();
          w.partOfSpeech = body[0]['meanings'][0]['partOfSpeech'].toString();
          w.definition = body[0]['meanings'][0]['definitions'][0]['definition'].toString();
          w.jsonResponse = body[0].toString();

          await save(w);
        }
      } catch(e){
        status.value = "Ocorreu um erro ao pegar os dados. Tente novamente.";
        loading.value = false;
      }
  }

  Future<int> save(Words w) async{
    print('iniciei o save');
    status.value = "Salvando a palavra no banco...";
    var x;
    try {
      x = await storeController.insert(w);
    } catch(e){
      status.value = "Ocorreu um erro ao salvar a palavra no banco...";
      loading.value = false;
    }
    print('valor da inserção $x');
    loading.value = false;
    return x;
  }
}