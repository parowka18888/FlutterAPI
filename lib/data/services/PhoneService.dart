import 'dart:convert';

import 'package:api/core/config/config.dart';
import 'package:api/data/models/Phone.dart';
import 'package:http/http.dart' as http;

class PhoneService{
  
  static Future<List<Phone>> getPhones() async{
    print("#### Wykonuje Phones");

    final url = Uri.parse("${Config.baseUrl}/objects");
    print("#### url to ${url}");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List decoded = jsonDecode(response.body);
      return decoded.map((json) => Phone.fromJson(json)).toList();
    } else {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }






}