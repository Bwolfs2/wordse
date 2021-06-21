import 'package:wordse_app/store/store_controller.dart';
import 'package:wordse_app/store/words_store.dart';
import 'package:flutter/material.dart';

class AddController {
  final storeController = StoreController();
  TextEditingController wordPortuguese = TextEditingController();
  TextEditingController wordEnglish = TextEditingController();
  TextEditingController definition = TextEditingController();
  TextEditingController partOfSpeech = TextEditingController();
  TextEditingController jsonResponse = TextEditingController();

  Future save(Words w) async{
    return await storeController.insert(w);
  }
}