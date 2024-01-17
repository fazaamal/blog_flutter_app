import '../auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'register_page.dart';

var username = "";
var password = "";
bool isValid = true;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  // todo - add register option if not registered

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('BlogGram', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
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
            const SizedBox(height: 24.0),
            if (!isValid)
              const Text(
                'Invalid username or password',
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse('http://localhost:3000/users'));

                if(response.statusCode == 200){
                  var data = jsonDecode(response.body) as List<dynamic>;

                  var userFound = data.firstWhere(
                    (obj) => obj['username'] == username && obj['password'] == password,
                    orElse: () => null,
                  );
 
                  if (userFound != null) {
                    AuthManager().login();

                    print("Valid login"); 

                    setState(() {
                      isValid = true;
                      AuthManager.isLoggedIn = true;
                      AuthManager.username = username;
                      AuthManager.name = userFound['name'];
                    });

                    Navigator.pop(context, { 'success': true, 'username': username, 'name': userFound['name']});
                    // Proceed with authenticated actions
                  } else {
                    print("Invalid login");
                    setState(() {
                      isValid = false;
                    });                    // Handle invalid login attempt
                  }

                }
                // print('Username: $username Password: $password');
                // Add your authentication logic here
                // For example, you can check credentials and navigate to the next screen
                // Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Login'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
              child: const Text("Don't have an account?", 
                style: TextStyle(color: Colors.blueAccent),
                textAlign: TextAlign.center,
              ),
            )
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

