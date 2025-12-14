import 'package:api/data/models/user.dart';

class Message{
  final String id;
  final String title;
  final String content;
  final User? user;

  Message({
   required this.id,
   required this.title,
   required this.content,
   this.user
  });

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      user: json['user'] != null
          ? User.fromJson(json['user'])
          : null,
    );
  }

}