import 'package:api/core/viewmodels/app_provider.dart';
import 'package:api/core/enums/selected_mode.dart';
import 'package:api/data/models/message.dart';
import 'package:api/data/services/message_service.dart';
import 'package:api/presentation/screens/startPage/main_panel/phone_data.dart';
import 'package:api/presentation/screens/startPage/main_panel/phones_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/dbs.dart';
import 'form_view.dart';

class MainPanel extends StatefulWidget{
  MainPanel({super.key, required this.width, required this.height});

  final double width;
  final double height;

  State<MainPanel> createState() => _MainPanel();
}

class _MainPanel extends State<MainPanel>{

  @override
  Widget build(BuildContext context) {

    AppProvider viewmodel = context.watch<AppProvider>();
    SelectedMode mode = viewmodel.selected_mode;

    return Container(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          //FIREBASE
          if(mode == SelectedMode.get)
            PhonesTable(
              key: ValueKey("GetAllFirebase"),
              init: (){viewmodel.loadPhones(Dbs.firebase);}
            ),
          if(mode == SelectedMode.getByID)
            PhoneData(
              key: ValueKey("GetIdFirebase"),
              init: (){viewmodel.loadPhoneById("QXVpdsy6h6tx2R1ZGbLL", Dbs.firebase);},
            ),
          if(mode == SelectedMode.post)
            FormView(),

          //JSON
          if(mode == SelectedMode.getStandard)
            PhonesTable(
                key: ValueKey("GetAllJson"),
                init: (){
                  viewmodel.loadPhones(Dbs.json);
                }
            ),
          if(mode == SelectedMode.getStandardID)
            PhoneData(
              key: ValueKey("GetIdJson"),
              init: (){viewmodel.loadPhoneById("1", Dbs.json);},),
          if(mode == SelectedMode.additional)
            PhonesTable(
                key: ValueKey("GetAdditional"),
                init: (){
                  viewmodel.loadAdditionArrays();
                }
            ),
        ],
      ),
    );
  }

}