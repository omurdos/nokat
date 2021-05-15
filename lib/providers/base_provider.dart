import 'package:flutter/material.dart';
import 'package:nokat/enums/app_state.dart';

class BaseProvider with ChangeNotifier {
  AppState _state = AppState.idle;

  AppState get state => _state;

  set state(AppState value) {
    _state = value;
    notifyListeners();
  }
}