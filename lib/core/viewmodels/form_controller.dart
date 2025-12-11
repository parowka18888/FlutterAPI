import 'package:api/core/enums/dbs.dart';
import 'package:api/core/helpers/string_helper.dart';
import 'package:api/core/viewmodels/app_provider.dart';
import 'package:api/data/services/PhoneService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/Phone.dart';
import '../../data/services/PhoneService_Firebase.dart';
import '../enums/selected_mode.dart';

class FormController extends ChangeNotifier{
  final nameController = TextEditingController();

  final colorController = TextEditingController();
  final capacityController = TextEditingController();
  final priceController = TextEditingController();
  final yearController = TextEditingController();

  void dispose(){
    super.dispose();
    nameController.dispose();
    colorController.dispose();
    capacityController.dispose();
    priceController.dispose();
    yearController.dispose();
  }

  Future<void> submit(BuildContext context, Dbs db) async {
    Phone phone = createPhone();
    AppProvider appProvider = context.read<AppProvider>();
    try {
      if(appProvider.chosenID == null){
        formAddPhone(phone, db);
      } else {
        phone.id = appProvider.chosenID;
        formEditPhone(phone, db);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zapisano!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Błąd!')),
      );
    }
  }

  void setForm(Phone phone) {
    nameController.text = phone.name;
    colorController.text = StringHelper.toStr(phone.data?["color"]);
    capacityController.text = StringHelper.toStr(phone.data?["capacity"]);
    priceController.text = StringHelper.toStr(phone.data?["price"]);
    yearController.text = StringHelper.toStr(phone.data?["year"]);
  }

  Phone createPhone() {
    return Phone(
        name: nameController.text,
        data: {
          if(capacityController.text.trim().isNotEmpty)
            "capacity": int.parse(capacityController.text),
          if(priceController.text.trim().isNotEmpty)
            "price": double.parse(priceController.text),
          if(yearController.text.trim().isNotEmpty)
            "year": int.parse(yearController.text),
          if(colorController.text.trim().isNotEmpty)
            "color": colorController.text,
        }
    );
  }

  void formAddPhone(Phone phone, Dbs db) {
    switch (db){
      case Dbs.firebase: { PhoneService_Firebase.savePhone(phone); break;}
      case Dbs.json: { PhoneService.savePhone(phone); break;}
    }
  }

  void formEditPhone(Phone phone, Dbs db) {
    switch (db){
      case Dbs.firebase: { PhoneService_Firebase.editPhone(phone); break;}
      case Dbs.json: { PhoneService.editPhone(phone); break;}
    }
  }

  void editPhone_Prepare(Phone phone, BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    appProvider.setSelectedMode(SelectedMode.post);
    appProvider.chosenID = phone.id;
    setForm(phone);
    notifyListeners();
  }

}