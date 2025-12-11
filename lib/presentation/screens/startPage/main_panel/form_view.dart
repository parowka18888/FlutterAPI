import 'package:api/core/viewmodels/form_controller.dart';
import 'package:api/data/services/PhoneService_Firebase.dart';
import 'package:api/data/validators/phone_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/dbs.dart';
import '../../../../data/models/Phone.dart';

class FormView extends StatefulWidget{
  FormView({super.key});
  
  State<FormView> createState() => _FormView();
}

class _FormView extends State<FormView>{

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    super.dispose();
  }

  void submit(Dbs db){
    if (_formKey.currentState!.validate()) {
      FormController formController = context.read<FormController>();
      formController.submit(context, db);
    }
  }

  @override
  Widget build(BuildContext context) {
    FormController formController = context.watch<FormController>();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: formController.nameController,
                  decoration: const InputDecoration(labelText: "Nazwa"),
                  validator: PhoneValidators.validateName,

                ),
                TextFormField(
                  controller: formController.colorController,
                  decoration: const InputDecoration(labelText: "Kolor"),
                  keyboardType: TextInputType.text,
                  validator: PhoneValidators.validateColor,
                ),
                TextFormField(
                  controller: formController.capacityController,
                  decoration: const InputDecoration(labelText: "Pojemność"),
                  keyboardType: TextInputType.number,
                  validator: PhoneValidators.validateNumber
                ),
                TextFormField(
                  controller: formController.priceController,
                  decoration: const InputDecoration(labelText: "Cena"),
                  keyboardType: TextInputType.number,
                  validator: PhoneValidators.validatePrice
                ),
                TextFormField(
                  controller: formController.yearController,
                  decoration: const InputDecoration(labelText: "Rok"),
                  keyboardType: TextInputType.number,
                  validator: PhoneValidators.validateNumber
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){submit(Dbs.json);}, child: Text("Dodaj do JSON")),
                    ElevatedButton(onPressed: (){submit(Dbs.firebase);}, child: Text("Dodaj do FIREBASE"))
                  ],
                )

              ],
            ),
          )
        ],
      )
    );
  }
  
}