import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/Phone.dart';
import '../../data/services/PhoneService_Firebase.dart';

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

  Future<void> submit(BuildContext context) async {
    Phone phone = Phone(
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
    try {
      await PhoneService_Firebase.savePhone(phone);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zapisano!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Błąd!')),
      );
    }
    PhoneService_Firebase.savePhone(phone);
  }
}