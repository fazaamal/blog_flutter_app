import 'dart:ffi';
import 'dart:io';

import '../auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var username = "";
var password = "";
bool isValid = true;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('BlogGram', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            const SizedBox(height: 24.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => username = value,

            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) => password = value,
            ),
            ElevatedButton(
              onPressed: () async {
                // todo - post to server, return back to login page
              
                // final response = await http.get(Uri.parse('http://localhost:3000/users'));

                // if(response.statusCode == 200){
                //   var data = jsonDecode(response.body) as List<dynamic>;

                //   var userFound = data.firstWhere(
                //     (obj) => obj['username'] == username && obj['password'] == password,
                //     orElse: () => null,
                //   );
 
                //   if (userFound != null) {
                //     AuthManager().login();

                //     print("Valid login"); 

                //     setState(() {
                //       isValid = true;
                //     });

                //     setState(() {
                //       AuthManager.isLoggedIn = true;
                //     });

                //     Navigator.pop(context);
                //     // Proceed with authenticated actions
                //   } else {
                //     print("Invalid login");
                //     setState(() {
                //       isValid = false;
                //     });                    // Handle invalid login attempt
                //   }

                // }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     initialRoute: '/',
//     routes: {
//       '/': (context) => LoginPage(),
//       '/home': (context) => MyHomePage(),
//     },
//   ));
// }

