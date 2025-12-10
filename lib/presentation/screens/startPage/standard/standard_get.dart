import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/Phone.dart';
import '../../../../data/services/PhoneService.dart';

class GetStandard extends StatefulWidget{
  GetStandard({super.key});

  State<GetStandard> createState() => _GetStandardState();
  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Text("Ojk"),
  //   );
  // }
  //
}

class _GetStandardState extends State<GetStandard> {

  late Future<List<Phone>> phones;


  @override
  void initState() {
    super.initState();
    // phones = PhoneService.getPhones();
    phones = PhoneService.getPhoneById("1").then((phone) => [phone]);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.green,
            child: FutureBuilder(
                future: phones,
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }
                  if(snapshot.hasError){
                    return Center(child: Text("${snapshot.error}"));
                  }
                  final list = snapshot.data!;
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index){
                        Phone phone = list[index];
                        return Text("${phone.name} -- ${phone.id} -- ${phone.data}");
                  });
                }
            ),
          )
        ],
      ),
    );
  }

}