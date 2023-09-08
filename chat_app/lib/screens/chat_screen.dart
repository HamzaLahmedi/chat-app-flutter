import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = 'ChatScreen';

  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
  var email =  ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt',descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messageList = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(
                MessageModel.fromJson(snapshot.data!.docs[i]),
              );
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 50,
                  ),
                  const Text('Scholar Chat')
                ]),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse:true ,
                        controller: _controller,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email ? ChatBuble(
                            message: messageList[index],
                          ):ChatBubleForFreind(message: messageList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add(
                            {'message': data, 'createdAt': DateTime.now(),'id':email});
                        controller.clear();
                        _controller.animateTo(
                            0,
                            duration:const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn);
                      },
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        hintText: 'Send Message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child:  CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
