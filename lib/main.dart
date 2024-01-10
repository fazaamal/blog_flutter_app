import 'package:blog_project/widgets/blog_list.dart';
import 'package:flutter/material.dart';
import 'widgets/app_bar.dart';
import './pages/login_page.dart';
import 'auth/auth_manager.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MainApp(),
      '/login':(context) => const LoginPage(),
      // '/home': (context) => MyHomePage(),
    },
  ));
  // runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog',
      home: Scaffold(
        appBar: MyAppBar2(title: "BlogGram"),
        body: 
        const Center(
          child: BlogList(),
        ),
        floatingActionButton: AuthManager.isLoggedIn ? FloatingActionButton(
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));

            Navigator.pushNamed(context, '/login');
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add)
        ): null
      )
    );
  }
}
