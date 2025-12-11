import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/viewmodels/app_provider.dart';
import '../../../../data/models/Phone.dart';

class PhonesTable extends StatefulWidget{
  PhonesTable({super.key, required this.init});
  final VoidCallback init;

  @override
  State<PhonesTable> createState() => _PhonesTableState();
}

class _PhonesTableState extends State<PhonesTable>{
  getDataCell(Phone phone, String name) {
    return DataCell(Text(
        phone.data != null && phone.data!.containsKey(name) ? phone.data![name].toString() :
        "---"
    ));
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => widget.init());
  }

  @override
  Widget build(BuildContext context) {

    AppProvider appProvider = context.watch<AppProvider>();

    return Center(
        // height: widget.height,
        // width:  widget.width,
        child: SingleChildScrollView(
          child: appProvider.isLoading ? CircularProgressIndicator() :
          DataTable(
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


}