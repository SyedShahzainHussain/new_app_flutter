import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CheckConnection with ChangeNotifier {
  ConnectivityResult _connectivityResult  = ConnectivityResult.none;

  CheckConnection() {
    Connectivity().onConnectivityChanged.listen((event) {
      _connectivityResult = event;
      notifyListeners();
    print(_connectivityResult);
    });
    Connectivity().checkConnectivity().then((result) {
      _connectivityResult = result;
      notifyListeners();
    });
  }

  ConnectivityResult get connectivityResult => _connectivityResult;
}
