import 'package:flutter/material.dart';

class MyMessagingField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  final IconData? icon;
  final FocusNode? focusNode;

  const MyMessagingField({super.key, required this.controller, required this.hinText, this.icon, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(color: Theme.of(context).colorScheme.secondaryContainer),
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondary,
              hintText: hinText,
              hintStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.background, width: 0)
              )
            ),
            
          ),
        )
      ],
    );
  }
}