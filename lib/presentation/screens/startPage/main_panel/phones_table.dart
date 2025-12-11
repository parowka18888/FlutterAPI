import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/viewmodels/app_provider.dart';
import '../../../../data/models/Phone.dart';

class PhonesTable extends StatelessWidget{
  PhonesTable({super.key, required this.width, required this.height});
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