import 'package:blog_project/widgets/blog_list.dart';
import 'package:flutter/material.dart';
import './pages/login_page.dart';
import 'auth/auth_manager.dart';
import './pages//register_page.dart';
import './pages//create_blog_page.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MainApp(),
      '/login':(context) => const LoginPage(),
      '/register':(context) => const RegisterPage(),
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
  bool refresh = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BlogGram'),
          backgroundColor: Colors.blueAccent,
          actions: [
            AuthManager.isLoggedIn ? IconButton(
              icon: const Icon(Icons.logout, color: Colors.black),
              onPressed: () {
                setState(() {
                  AuthManager().logout();
                  AuthManager.isLoggedIn = false;
                  AuthManager.username = "";
                  AuthManager.name = "";
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ) :
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.black),
              onPressed: () async {
                print("Login button pressed");
                // Navigate to the login page when the account button is pressed
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );

                if (result['success'] == true) {
                  setState(() {
                    AuthManager.isLoggedIn = true;
                    AuthManager.username = result['username'];
                    AuthManager.name = result['name'];
                  });
                }
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {

            print("Refreshed");
            setState(() {
              refresh = true;
            });

            await Future.delayed(const Duration(seconds: 1));
            print("delay");

            setState(() {
              refresh = false;
            });
          },
          child: Center(
          child: 
            refresh ? const CircularProgressIndicator() : const BlogList(),
        ),)
        ,
        floatingActionButton: AuthManager.isLoggedIn ? FloatingActionButton(
          onPressed: () async {
            var res = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlogPage(author: AuthManager.getName())));

            print(res);
            if(res ==true){
              setState(() {
                refresh = true;
              });

              await Future.delayed(const Duration(seconds: 1));

              setState(() {
                refresh = false;
              });
            }
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add)
        ): null
      )
    );
  }
}
