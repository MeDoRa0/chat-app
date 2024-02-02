import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/models/message_model.dart';

import '../../../constant.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  List<Message> messagesList = [];
//method for sending messages
  void sendMessage({required String message, required dynamic email}) {
    try {
      messages.add(
        {
          kMessage: messages,
          //time when message sent
          kCreatedAt: DateTime.now(), 'id': email
        },
      );
    } on Exception catch (e) {}
  }

//method for reciving messages
  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      //this to clear messagesList so
      messagesList.clear();
      for (var doc in event.docs) {
        //to get new messages
        messagesList.add(Message.fromJason(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
