import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String message;
  final String time;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, required this.onTap, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Theme.of(context).colorScheme.primary,width: .6)),
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary,)
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 4),
                  Text(message, style: TextStyle(color: Colors.grey[600]),)
                ],
              ),
            ),
            Text(time, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),)
          ],
        ),
      ),
    );
  }
}