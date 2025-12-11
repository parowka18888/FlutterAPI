import 'package:api/core/enums/dbs.dart';
import 'package:api/core/enums/selected_mode.dart';
import 'package:api/data/services/PhoneService.dart';
import 'package:api/data/services/PhoneService_Firebase.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/Phone.dart';

class AppProvider extends ChangeNotifier{

  SelectedMode selected_mode = SelectedMode.getStandard;

  bool isLoading = false;
  List<Phone> phones = [];
  Phone? phone = null;

  void setSelectedMode(SelectedMode mode){
    selected_mode = mode;
    notifyListeners();
  }

  Future<void> loadPhones(Dbs db) async {
    isLoading = true;
    notifyListeners();
    switch (db){
      case Dbs.firebase: { phones = await PhoneService_Firebase.getPhones(); break;}
      case Dbs.json: { phones = await PhoneService.getPhones();break;}
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadPhoneById(String id, Dbs db) async {
    phone = null;
    isLoading = true;
    notifyListeners();
    switch (db){
      case Dbs.firebase: { phone = await PhoneService_Firebase.getPhoneByID(id); break;}
      case Dbs.json: { phone = await PhoneService.getPhoneById(id);break;}
    }
    isLoading = false;
    notifyListeners();
  }

  void deletePhone(String id) {
    PhoneService_Firebase.deletePhone(id);
    notifyListeners();
  }

}