import 'package:api/data/models/Phone.dart';
import 'package:api/data/services/PhoneService.dart';
import 'package:api/presentation/screens/startPage/firebase/firebase_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget{
  const StartPage({super.key});
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>{

  late Future<List<Phone>> phones;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("Startowaaaa"),
            // Container(
            //   height: 400,
            //   width: 400,
            //   color: Colors.purple,
            //   child: FutureBuilder(
            //       future: phones,
            //       builder: (context, snapshot){
            //         if(snapshot.connectionState == ConnectionState.waiting){
            //           return const Center(child:  CircularProgressIndicator());
            //         }
            //         if(snapshot.hasError){
            //           return Center(child: Text("${snapshot.error}"));
            //         }
            //         final list = snapshot.data!;
            //         return ListView.builder(
            //             itemCount: list.length,
            //             itemBuilder: (context, index){
            //               Phone element = list[index];
            //               return Container(
            //                 child: Text("${element.id} --- ${element.name} --- ${element.data}"),
            //               );
            //             });
            //       }),
            // ),
            FireBaseScreen()

          ],
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    phones = PhoneService.getPhones();
  }
}