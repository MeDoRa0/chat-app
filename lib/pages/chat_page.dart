import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:scholar_chat/pages/cubit/chat_cubit/chat_cubit.dart';
import '../widgets/chat_bubble.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
//to make page scroll down when every new message arrive
  final ScrollController _controller = ScrollController();
  List<Message> messagesList = [];

  //this will control textfield
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //to recive data come with argument from login and sigup pages
    var email = ModalRoute.of(context)!.settings.arguments; //as dynamic;

    return Scaffold(
      appBar: AppBar(
        //it hide back arrow
        automaticallyImplyLeading: true,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            Text("Chat"),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            //we use blocconsumer with listview because we want to rebuild the messeages only
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                //this to get all messages
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                //messages will appear here
                return ListView.builder(
                  reverse: true,
                  //i give controller to listview
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    // i access messageList to see the message he is building and ask for id, if id = current user email so build user message
                    return messagesList[index].id == email
                        ? ChatBubble(
                            message: messagesList[index],
                            //if id != current user email , so this message is from another user so build another user chatbubbleR
                          )
                        : ChatBubbleR(
                            message: messagesList[index],
                          );
                  },
                );
              },
            ),
          ),
          TextField(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                //to control textfield
                controller: controller,
                //to send message when user press send
                onSubmitted: (data) {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMessage(message: data, email: email);
                  //it will clear textfield after user press send
                  controller.clear();
                  //when user submit message the controller will scroll down to last message sent
                  _controller.animateTo(
                    0,
                    duration: Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                  );
                },

                decoration: InputDecoration(
                    hintText: "Send message",
                    suffixIcon: Icon(
                      Icons.send,
                      color: kPrimaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: kPrimaryColor),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
