import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String hintText;
  final bool obscuretext;
  final FocusNode? focusNode;
  const MyTextField({super.key, required this.controller, required this.hintText, required this.obscuretext, this.focusNode, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.inversePrimary,),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            style: TextStyle(color: Theme.of(context).colorScheme.secondaryContainer),
            controller: controller,
            focusNode: focusNode,
            obscureText: obscuretext,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary,width: 2)
              ),
              border: UnderlineInputBorder()
            ),
          ),
        ),
      ],
    );
  }
}