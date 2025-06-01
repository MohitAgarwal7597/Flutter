import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppProvider extends ChangeNotifier {
  String? _username = 'Guest007';
  String? get username => _username;

  set setUsername(String value) {
    _username = value;
    Hive.box('userBox').put('username', value); // Save to Hive
    notifyListeners();
  }

  void loadUsernameFromHive() {
    _username = Hive.box('userBox').get('username');
    notifyListeners();
  }

  bool get isUsernameSet => _username != null;
}
