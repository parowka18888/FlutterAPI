import 'package:api/core/enums/selected_mode.dart';
import 'package:api/presentation/screens/startPage/side_panel/button_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SidePanelFirebase extends StatelessWidget{

  SidePanelFirebase({super.key, required this.width, required this.height});

  final double width;
  final double height;


  @override
  Widget build(BuildContext context) {
    final buttons = SelectedMode.values.toList();
    final double button_Width = width;
    final double button_Height = height / buttons.length;

    return Container(
      width: width,
      height: height,
      color: Colors.purple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons.map((element){
          return ButtonFirebase(width: button_Width, height: button_Height, buttonMode: element);
        }).toList()
      ),
    );
  }

}