import 'package:flutter/material.dart';
import '../pages/login_page.dart'; // Import your login page file here
import '../auth/auth_manager.dart';

class MyAppBar2 extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Image? logo;

  const MyAppBar2({Key? key, required this.title, this.logo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppBar2State();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MyAppBar2State extends State<MyAppBar2> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title, style: const TextStyle(fontSize: 20, color: Colors.black)),
      // title: widget.logo ?? Text(widget.title.toUpperCase(), style: const TextStyle(fontSize: 20, color: Colors.black)),
      backgroundColor: Colors.blueAccent,
      actions: [
        AuthManager.isLoggedIn ? IconButton(
          icon: const Icon(Icons.logout, color: Colors.black),
          onPressed: () {
            setState(() {
              AuthManager().logout();
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ) :
        IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.black),
          onPressed: () {
            // Navigate to the login page when the account button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ],
    );
  }
}