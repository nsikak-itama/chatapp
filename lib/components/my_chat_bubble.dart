import 'package:flutter/material.dart';

class MyChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const MyChatBubble({super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: isCurrentUser? Colors.green : Theme.of(context).colorScheme.primary
      ),
      child: Text(
        message,
        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary),
      ),
    );
  }
}