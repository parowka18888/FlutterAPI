import 'dart:convert';

import 'package:api/core/config/config.dart';
import 'package:api/data/models/Phone.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PhoneService{
  
  static Future<List<Phone>> getPhones() async{
    final url = Uri.parse("${Config.baseUrl}/phones");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List decoded = jsonDecode(response.body);
      return decoded.map((json) => Phone.fromJson(json)).toList();
    } else {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }

  static Future<Phone> getPhoneById(String id) async {
    final url = Uri.parse('${Config.baseUrl}/phones/${id}');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final Map<String, dynamic> decode = jsonDecode(response.body);
      return Phone.fromJson(decode);
    } else {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }

  static Future<Phone> savePhone(Phone phone) async {
    phone.id = Uuid().v4().substring(0,8);
    print(phone.id);
    final url = Uri.parse('${Config.baseUrl}/phones');
    final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(phone.toMap()),
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return Phone.fromJson(decoded);
    } else {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }

  static Future<void> deletePhone(String id) async {
    final url = Uri.parse('${Config.baseUrl}/phones/$id');
    final response = await http.delete(url);

    if(response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }

  static Future<Phone> editPhone(Phone phone) async {
    final url = Uri.parse("${Config.baseUrl}/phones/${phone.id}");
    final response = await http.put(
        url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(phone.toMap())
    );
    if(response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return Phone.fromJson(decoded);
    } else {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }






}