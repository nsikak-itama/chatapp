import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async{
    if(confirmPasswordController.text != passwordController.text){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords don't match")));
      return;
    }
    final _authService = Provider.of<AuthService>(context, listen: false);
    try{
      await _authService.signUpWithEmailAndPassword(emailController.text, passwordController.text, nameController.text);
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Icon(
                Icons.message,
                size: 80,
              ),
              SizedBox(height: 50),
              Text("Create a new account", style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              MyTextField(controller: nameController, hintText: "Full name", obscuretext: false),
              SizedBox(height: 10),
              MyTextField(
                controller: emailController, 
                hintText: "Email Address", 
                obscuretext: false,
              ),
              SizedBox(height: 10),
              MyTextField(controller: passwordController, hintText: "Password", obscuretext: true),
              SizedBox(height: 20),
              MyTextField(controller: confirmPasswordController, hintText: "Confirm Password", obscuretext: true),
              SizedBox(height: 20),
              MyButton(text: "Sign up", onTap: signUp,),
              SizedBox(height: 50),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Alreday a member?"),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Sign in',style: TextStyle(color: Colors.blue),)
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );;
  }
}