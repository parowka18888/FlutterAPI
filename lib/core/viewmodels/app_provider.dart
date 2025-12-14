import 'package:api/core/enums/dbs.dart';
import 'package:api/core/enums/selected_mode.dart';
import 'package:api/core/viewmodels/form_controller.dart';
import 'package:api/data/services/PhoneService.dart';
import 'package:api/data/services/PhoneService_Firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../data/models/Phone.dart';
import '../../data/models/message.dart';
import '../../data/services/message_service.dart';

class AppProvider extends ChangeNotifier{

  SelectedMode selected_mode = SelectedMode.getStandard;

  bool isLoading = false;
  List<Phone> phones = [];
  Phone? phone = null;
  Dbs currentDb = Dbs.firebase;
  String? chosenID;

  void setSelectedMode(SelectedMode mode){
    selected_mode = mode;
    chosenID = null;
    notifyListeners();
  }


  Future<void> loadPhones(Dbs db) async {
    isLoading = true;
    notifyListeners();
    switch (db){
      case Dbs.firebase: { phones = await PhoneService_Firebase.getPhones(); break;}
      case Dbs.json: { phones = await PhoneService.getPhones();break;}
    }
    currentDb = db;
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
    currentDb = db;
    isLoading = false;
    notifyListeners();
  }

  Future<void> deletePhone(String id) async {
    switch (currentDb){
      case Dbs.firebase: { await PhoneService_Firebase.deletePhone(id); break;}
      case Dbs.json: { await PhoneService.deletePhone(id);break;}
    }
    loadPhones(currentDb);
    notifyListeners();
  }

  Future<void> loadAdditionArrays() async {
    List<Message> messages = await MessageService.getMessages();
    for(final Message message in messages){
      print("ID: ${message.id}");
      print("TITLE: ${message.title}");
      print("CONTENT: ${message.content}");
      print("USER: ${message.user?.id}, ${message.user?.name}, ${message.user?.email}");
      print("#########################");
    }
  }

  // void editPhone_Prepare(Phone phone, BuildContext context) {
  //   FormController formController = context.read<FormController>();
  //   formController.setForm(phone);
  //   selected_mode = SelectedMode.post;
  //   chosenID = phone.id;
  //   notifyListeners();
  // }

}