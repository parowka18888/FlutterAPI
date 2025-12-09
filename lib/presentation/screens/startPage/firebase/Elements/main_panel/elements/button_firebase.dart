import 'package:api/core/appdata/app_provider.dart';
import 'package:api/core/enums/selected_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonFirebase extends StatefulWidget{

  ButtonFirebase({super.key, required this.width, required this.height, required this.buttonMode});

  final double width;
  final double height;
  final SelectedMode buttonMode;

  State<ButtonFirebase> createState() => _ButtonFirebase();
}

class _ButtonFirebase extends State<ButtonFirebase>{

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<AppProvider>();
    bool isSelected = widget.buttonMode == viewModel.selected_mode ? true : false;
    double opacity = isSelected ? 1.0 : 0.5;

    return GestureDetector(
      onTap: (){
        print(widget.buttonMode);
        viewModel.setSelectedMode(widget.buttonMode);
      },
      child: Opacity(
          opacity: opacity,
        child: Container(
          height: widget.height,
          width: widget.width,
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.buttonMode.name)
            ],
          ),
        ),
      )
    );
  }

}