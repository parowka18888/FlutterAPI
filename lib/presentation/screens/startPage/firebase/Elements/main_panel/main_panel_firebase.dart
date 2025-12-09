import 'package:api/core/appdata/app_provider.dart';
import 'package:api/core/enums/selected_mode.dart';
import 'package:api/presentation/screens/startPage/firebase/Elements/main_panel/post_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPanelFirebase extends StatefulWidget{
  MainPanelFirebase({super.key, required this.width, required this.height});

  final double width;
  final double height;

  State<MainPanelFirebase> createState() => _MainPanelFirebase();
}

class _MainPanelFirebase extends State<MainPanelFirebase>{

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
          if(mode == SelectedMode.get)
            Text("nie"),
          if(mode == SelectedMode.post)
            PostFirebase()
        ],
      ),
    );
  }

}