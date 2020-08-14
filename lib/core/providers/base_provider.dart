import 'package:flutter/material.dart';
import 'package:super_hero/core/enums/viewstate.dart';

class BaseProvider extends ChangeNotifier {

  Future<T> syncTreatment<T>(Function func) async {
    try {
      setLoadingState(ViewState.busy);
      final result = await func();
      setLoadingState(ViewState.idle);
      return result;
    }finally{
      setLoadingState(ViewState.idle);
    }
  }

  static ViewState _state = ViewState.idle;
  ViewState get state => _state;
  void setLoadingState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
