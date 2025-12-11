import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Phone.dart';

class PhoneService_Firebase{

  static Future<void> savePhone(Phone phone) async{
    await FirebaseFirestore.instance
        .collection('phones')
        .add(phone.toMap());
        // .doc(phone.id)
        // .set(phone.toMap());
  }

  static Future<void> deletePhone(String id) async{
    await FirebaseFirestore.instance
        .collection('phones')
        .doc(id)
        .delete();
  }

  static Future<List<Phone>> getPhones() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('phones').get();
    return snapshot.docs.map((doc){
      return Phone.fromFirestore(doc);
    }).toList();
  }

  static Future<Phone?> getPhoneByID(String id) async {
    final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('phones').doc(id).get();
    print("NIE ZNALEZIONO!");
    if(!doc.exists) return null;
    print("ZNALEZIONO!");
    return Phone.fromFirestore(doc);
  }



}