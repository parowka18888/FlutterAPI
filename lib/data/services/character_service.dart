import 'dart:convert';

import 'package:api/core/config/config.dart';
import 'package:api/data/models/character.dart';
import 'package:http/http.dart' as http;

class CharacterService{

  static Future<List<Character>> getCharacters() async {
    final url = Uri.parse("${Config.baseUrl}/characters");
    final response = await http.get(url);

    if(response.statusCode == 200){
    final List<dynamic> decode = jsonDecode(response.body);
      return decode.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception("Błąd: ${response.statusCode}");
    }
  }

  static Future<Character> getCharacterById(int id) async {
    final url = Uri.parse("${Config.baseUrl}/characters/$id");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final decode = json.decode(response.body);
      return Character.fromJson(decode);
    } else {
      throw Exception("Błąd: ${response.statusCode}");
    }
  }

  static Future<Character> saveCharacter(Character character) async {
    final url = Uri.parse('${Config.baseUrl}/characters');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(character.toMap())
    );

    if(response.statusCode == 200 || response.statusCode == 201){
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return Character.fromJson(decoded);
    }
    else {
      throw Exception("Błąd: ${response.statusCode}");
    }
  }

  static Future<void> deleteCharacter(String id) async {
    final url = Uri.parse('${Config.baseUrl}/characters/$id');
    final response = await http.delete(url);

    if(response.statusCode != 200 && response.statusCode != 204){
      throw Exception("Błąd: ${response.statusCode}");
    }
  }
  
  static Future<Character> editCharacter(Character character) async{
    final url = Uri.parse('${Config.baseUrl}/characters/${character.id}');
    final response = await http.put(
        url,
      headers: {'Content-Type': "application/json"},
      body: jsonEncode(character.toMap())
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return Character.fromJson(decoded);
    } else {
      throw Exception("Bład ${response.statusCode}");
    }
  }







}