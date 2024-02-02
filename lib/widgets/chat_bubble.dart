import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message_model.dart';
import '../constant.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        //width: 250,
        padding: EdgeInsets.only(
          left: 16,
          top: 25,
          bottom: 25,
          right: 16,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: kPrimaryColor,
        ),
        child: Text(
          message.message!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

//another chat bubble called ChatBubbleR for recived messages
class ChatBubbleR extends StatelessWidget {
  const ChatBubbleR({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        //width: 250,
        padding: EdgeInsets.only(
          left: 16,
          top: 25,
          bottom: 25,
          right: 16,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Colors.orange,
        ),
        child: Text(
          message.message!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
