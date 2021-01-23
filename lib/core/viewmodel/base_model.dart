import 'package:flutter/material.dart';
import 'package:momentum_test/core/enumaration/view_state.dart';

class BaseModel extends ChangeNotifier{
  ViewState _state = ViewState.Idle;
  bool _gmsAvailable = true;
  List<int> loadingItems = [];

  ViewState get state => _state;
  bool get gmsAvailable => _gmsAvailable;

  void setState(ViewState viewState) {
    if(viewState == ViewState.Busy) {
      _state = viewState;
      notifyListeners();
      loadingItems.add(loadingItems.length);
    } else {
      if(loadingItems.isNotEmpty) {
        loadingItems.removeLast();
      }
      if(loadingItems.isEmpty) {
        _state = viewState;
        notifyListeners();
      }
    }

  }
}