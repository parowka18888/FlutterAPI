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
}