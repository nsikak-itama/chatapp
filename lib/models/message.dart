import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderId;
  final String senderEmail;
  final String senderName;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message(this.senderId, this.senderEmail, this.receiverId, this.message, this.senderName, this.timestamp);

  Map<String, dynamic> toMap(){
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'senderName': senderName,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp
    };
  }
}