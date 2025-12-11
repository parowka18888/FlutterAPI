import 'package:api/core/viewmodels/app_provider.dart';
import 'package:api/core/enums/selected_mode.dart';
import 'package:api/presentation/screens/startPage/firebase/post_firebase.dart';
import 'package:api/presentation/screens/startPage/main_panel/phone_data.dart';
import 'package:api/presentation/screens/startPage/main_panel/phones_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/dbs.dart';

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
      color: Colors.pink,
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
            PostFirebase(),

          //JSON
          if(mode == SelectedMode.getStandard)
            PhonesTable(
                key: ValueKey("GetAllJson"),
                init: (){viewmodel.loadPhones(Dbs.json);}
            ),
          if(mode == SelectedMode.getStandardID)
            PhoneData(
              key: ValueKey("GetIdJson"),
              init: (){viewmodel.loadPhoneById("1", Dbs.json);},),
        ],
      ),
    );
  }

}