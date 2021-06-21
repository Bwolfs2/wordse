import 'package:flutter/material.dart';

class HomeController {
  ValueNotifier _index = ValueNotifier(0);

  ValueNotifier get valueIndex => _index;
  int get index => _index.value;

  set index(int i){
    _index.value = i;
  }
}