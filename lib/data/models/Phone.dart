import 'package:cloud_firestore/cloud_firestore.dart';

class Phone{
  String? id;
  final String name;
  final Map<String, dynamic>? data;

  Phone({
    this.id,
    required this.name,
    this.data
  });

  factory Phone.fromJson(Map<String, dynamic> json){
    return Phone(
      id: json["id"] as String?,
      name: json['name'] as String,
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null
    );
  }

  factory Phone.fromFirestore(DocumentSnapshot doc){
    final json = doc.data() as Map<String, dynamic>;

    return Phone(
      id: doc.id,
      name: json['name'],
      data: json["data"]
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'data': data
    };
  }

}