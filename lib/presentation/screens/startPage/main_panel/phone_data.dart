import 'package:api/core/viewmodels/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneData extends StatefulWidget{
  PhoneData({super.key, required this.init});

  final VoidCallback init;
  State<PhoneData> createState() => _PhoneDataState();
}

class _PhoneDataState extends State<PhoneData>{
  @override
  void initState() {
    super.initState();
    Future.microtask(() => widget.init());
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.watch<AppProvider>();

    return Center(
        child: appProvider.isLoading ?
        CircularProgressIndicator()  :
            appProvider.phone == null ?
                Text("Nie znaleziono elementu") :
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Nazwa: ${appProvider.phone!.name}"),
                     Text("Rok: ${appProvider.phone?.data?['year']}"),
                     Text("Kolor: ${appProvider.phone?.data?['color']}"),
                     Text("Cena: ${appProvider.phone?.data?['price']}"),
                     Text("Pojemność: ${appProvider.phone?.data?['capacity']}"),
                   ],
                 )
    );
  }

}