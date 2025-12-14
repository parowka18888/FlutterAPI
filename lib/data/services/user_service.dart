import 'dart:convert';

import 'package:api/core/config/config.dart';
import 'package:api/data/models/user.dart';
import 'package:http/http.dart' as http;

class UserService{

  static Future<User> getUserById(String id) async {
    final url = Uri.parse("${Config.baseUrl}/users/$id");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final Map<String, dynamic> decode = jsonDecode(response.body);
      return User.fromJson(decode);
    } else {
      throw Exception("Błąd: ${response.statusCode}");
    }
  }
}