import 'package:api/core/viewmodels/app_provider.dart';
import 'package:api/data/models/Phone.dart';
import 'package:api/data/services/PhoneService.dart';
import 'package:api/data/services/PhoneService_Firebase.dart';
import 'package:api/presentation/screens/startPage/firebase/Elements/main_panel/elements/table_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetFirebase extends StatefulWidget{
  GetFirebase({super.key});
  State<GetFirebase> createState() => _GetFirebaseState();
}

class _GetFirebaseState extends State<GetFirebase>{

  // late Future<List<Phone>> phones;


  @override
  void initState() {
    super.initState();

    // phones = PhoneService.getPhones();
    // phones = PhoneService_Firebase.getPhones();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppProvider>(context, listen: false).loadPhones();
    });

  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    AppProvider appProvider = context.watch<AppProvider>();

    final tableWidth = width * 0.8;
    final tableHeight = height * 0.8;
    return Center(
      child: appProvider.isLoading
          ? CircularProgressIndicator()
          : TableFirestore(
        phones: appProvider.phones,
        width: tableWidth,
        height: tableHeight,
      ),
    );

    // return Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Container(
    //         height: height,
    //         width: width,
    //         color: Colors.green,
    //         child: FutureBuilder(
    //             future: phones,
    //             builder: (context, snapshot){
    //               if(snapshot.connectionState == ConnectionState.waiting){
    //                 return const Center(child: CircularProgressIndicator());
    //               }
    //               if(snapshot.hasError){
    //                 return Center(child: Text("${snapshot.error}"));
    //               }
    //               final list = snapshot.data!;
    //               return TableFirestore(phones: list, width: tableWidth, height: tableHeight,);
    //             }
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

}