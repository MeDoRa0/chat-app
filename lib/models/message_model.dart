import 'package:scholar_chat/constant.dart';

class Message {
  final String? message;
  final String? id;
  //constructor
  Message(this.message, this.id);
  //factory constructor,
  factory Message.fromJason(jsonData) {
    return Message(jsonData[kMessage],jsonData['id']);
  }
}
