import 'package:api/core/viewmodels/app_provider.dart';
import 'package:api/data/models/Phone.dart';
import 'package:api/data/services/PhoneService_Firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableFirestore extends StatelessWidget{
  TableFirestore({super.key, required this.phones, required this.width, required this.height});
  final List<Phone> phones;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {

    AppProvider appProvider = context.watch<AppProvider>();

    return Container(
      height: height,
      width: width,
      color: Colors.pink,
      child: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Expanded(child: Text('ID'))),
            DataColumn(label: Expanded(child: Text('Nazwa'))),
            DataColumn(label: Expanded(child: Text('Cena'))),
            DataColumn(label: Expanded(child: Text('Kolor'))),
            DataColumn(label: Expanded(child: Text('Pojemność'))),
            DataColumn(label: Expanded(child: Text('Rok'))),
            DataColumn(label: Expanded(child: Text('Usuń'))),

          ],
          rows: appProvider.phones.map(
                  (phone) => DataRow(
                  cells: [
                    DataCell(Text(phone.id == null ? "---" : "${phone.id}")),
                    DataCell(Text(phone.name)),
                    getDataCell(phone, "price"),
                    getDataCell(phone, "color"),
                    getDataCell(phone, "capacity"),
                    getDataCell(phone, "year"),
                    DataCell(
                      ElevatedButton(
                        onPressed: (){
                          if(phone.id != null){
                            appProvider.deletePhone(phone.id!);
                             // PhoneService_Firebase.deletePhone(phone.id!);
                          }
                        },
                        child: Text("Usuń"),
                      )
                    ),
                  ]
              )
          ).toList(),
        ),
      )
    );
  }

  getDataCell(Phone phone, String name) {
    return DataCell(Text(
        phone.data != null && phone.data!.containsKey(name) ? phone.data![name].toString() :
        "---"
    ));
  }


}