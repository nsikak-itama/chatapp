import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async{
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
    } catch (e) {
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
              Text("Welcome back, you've been missed", style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              MyTextField(
                controller: emailController, 
                hintText: "Email Address", 
                obscuretext: false,
              ),
              SizedBox(height: 10),
              MyTextField(controller: passwordController, hintText: "Password", obscuretext: true),
              SizedBox(height: 20),
              MyButton(text: "Login", onTap: signIn,),
              SizedBox(height: 50),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?"),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Register',style: TextStyle(color: Colors.blue),)
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}