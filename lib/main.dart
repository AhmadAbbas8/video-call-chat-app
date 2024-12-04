import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_chat_app/features/auth/view/screens/login_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
         scaffoldBackgroundColor: Colors.grey[300],
      ),
      home: LoginScreen(),
    );
  }
}