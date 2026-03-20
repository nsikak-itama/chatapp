import 'package:chatapp/components/my_chat_bubble.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;
  final String receiverUserName;

  const ChatPage({super.key,required this.receiverUserEmail, required this.receiverUserId, required this.receiverUserName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myFocusNode.addListener((){
      if(myFocusNode.hasFocus){
        Future.delayed(
          Duration(milliseconds: 500), 
          () => scrollDown()
        );
      }
    });

    Future.delayed(
      Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }



  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }


  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }

    scrollDown();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background ,
      appBar: AppBar(
        
        title: Text(widget.receiverUserName),
      ),

      body: Column(
        children: [
          Expanded(
            child: _buildMessageList()
          ),

          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverUserId, _firebaseAuth.currentUser!.uid), 
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Text('Error${snapshot.error}');
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return Text("loading...");
        }

        return ListView(
          controller: _scrollController,
          padding: EdgeInsets.all(10),
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
      }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var aligment = (data['senderId'] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft ;
    return Container(
      alignment: aligment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          MyChatBubble(message: data['message'], isCurrentUser: data['senderId'] == _firebaseAuth.currentUser!.uid,)
        ],
      ),
    );
  }

  Widget _buildMessageInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0, left: 25),

      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController, 
              hintText: "Enter message", 
              obscuretext: false,
              focusNode: myFocusNode,
            ),
          ),
          IconButton(onPressed: sendMessage, icon: Icon(Icons.send, size: 40,))
        ],
      ),
    );
  }
}