import 'package:api/data/models/Phone.dart';
import 'package:api/data/services/PhoneService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_panel/main_panel.dart';
import 'side_panel/side_panel_firebase.dart';

class StartPage extends StatefulWidget{
  const StartPage({super.key});
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>{

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    double sidePanel_Width = width * 0.2;
    double sidePanel_Height = height;

    double mainPanel_Width = width - sidePanel_Width;
    double mainPanel_Height = height;

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SidePanelFirebase(width: sidePanel_Width, height: sidePanel_Height),
            MainPanel(width: mainPanel_Width, height: mainPanel_Height,)
          ],
        ),
      ),
    );
  }


}