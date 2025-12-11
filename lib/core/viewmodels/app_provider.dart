import 'package:api/core/enums/selected_mode.dart';
import 'package:api/data/services/PhoneService_Firebase.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/Phone.dart';

class AppProvider extends ChangeNotifier{

  SelectedMode selected_mode = SelectedMode.getStandard;

  bool isLoading = false;
  List<Phone> phones = [];
  late Phone? phone;

  void setSelectedMode(SelectedMode mode){
    selected_mode = mode;
    notifyListeners();
  }

  Future<void> loadPhones() async {
    isLoading = true;
    notifyListeners();

    phones = await PhoneService_Firebase.getPhones();
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadPhoneById(String id) async {
    isLoading = true;
    notifyListeners();
    phone = await PhoneService_Firebase.getPhoneByID(id);
    isLoading = false;
    notifyListeners();
  }

  void deletePhone(String id) {
    PhoneService_Firebase.deletePhone(id);
    loadPhones();
    notifyListeners();
  }

}