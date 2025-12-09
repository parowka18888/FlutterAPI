import 'package:api/presentation/screens/startPage/firebase/Elements/main_panel/main_panel_firebase.dart';
import 'package:api/presentation/screens/startPage/firebase/Elements/side_panel/side_panel_firebase.dart';
import 'package:flutter/cupertino.dart';

class FireBaseScreen extends StatefulWidget{
  FireBaseScreen({super.key});
  
  State<FireBaseScreen> createState() => _FireBaseScreenState();
}

class _FireBaseScreenState extends State<FireBaseScreen>{
  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    double sidePanel_Width = width * 0.2;
    double sidePanel_Height = height;

    double mainPanel_Width = width - sidePanel_Width;
    double mainPanel_Height = height;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SidePanelFirebase(width: sidePanel_Width, height: sidePanel_Height),
          MainPanelFirebase(width: mainPanel_Width, height: mainPanel_Height,)
        ],
      ),
    );
  }
  
}