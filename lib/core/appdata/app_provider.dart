import 'package:api/core/enums/selected_mode.dart';
import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier{

  SelectedMode selected_mode = SelectedMode.get;

  void setSelectedMode(SelectedMode mode){
    selected_mode = mode;
    notifyListeners();
  }

}