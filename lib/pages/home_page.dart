import 'package:chatapp/components/my_drawer.dart';
import 'package:chatapp/components/user_tile.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
  }

 Future<void> _loadUserName() async {
  final uid = _auth.currentUser?.uid;
  if (uid != null) {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (mounted) {          // ← guard against widget being disposed
      setState(() {
        _userName = doc.data()?['name'] ?? '';
      });
    }
  }
}
  
  void signOut(){
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        titleSpacing: 25, 
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello,", style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary),),
            _userName.isEmpty ? SizedBox(height: 36, width: 120, child: LinearProgressIndicator(),) :
            Text(_userName, style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      endDrawer: MyDrawer(onLogout: signOut),

      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(), 
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text('error');
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('loading...');
        }

        return ListView(
          padding: EdgeInsets.zero,
          children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      }
    );
  }
  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if(_auth.currentUser?.email != data['email']){
      return UserTile(
        text: data['name'],
        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
          receiverUserEmail: data['email'], 
          receiverUserId: data['uid'],
            receiverUserName: data['name'],
          )));
          }
      );
    } else{
      return Container();
    }
  }
}