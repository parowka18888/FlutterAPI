import 'dart:convert';

import 'package:api/core/config/config.dart';
import 'package:api/data/models/message.dart';
import 'package:http/http.dart' as http;

class MessageService{

  static Future<List<Message>> getMessages() async {
    final url = Uri.parse("${Config.baseUrl}/messages");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List decoded = jsonDecode(response.body);
      print(response.body);
      return decoded.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception("Błąd: ${response.statusCode}");
    }
  }
}