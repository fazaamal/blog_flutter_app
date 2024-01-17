// import 'dart:ffi';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var name = "";
var username = "";
var password = "";
bool isValid = true;
String error = "";

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
            const Text('Create an Account', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            const SizedBox(height: 24.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => name = value,

            ),
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
            !isValid ? Text(error, style: const TextStyle(color: Colors.red)) : const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                try{
                  if(name == "" || username == "" || password == ""){
                    setState(() {
                      isValid = false;
                      error = "Please fill out all fields";
                    });
                    return;
                  }

                  var doesExist = false;
                  
                  await http.get(Uri.parse("http://localhost:3000/users")).then((res) => {
                    for (var user in (jsonDecode(res.body) as List<dynamic>)){
                      if(user['username'] as String == username){
                        // Remove the 'return' statement
                        doesExist = true
                      }
                    }
                  });

                  if(doesExist){
                    setState(() {
                      isValid = false;
                      error = "Username already exists";
                    });
                    return;
                  }else{
                    setState(() {
                      isValid = true;
                    });                    
                  }

                  await http.post(
                    Uri.parse('http://localhost:3000/users'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'name': name,
                      'username': username,
                      'password': password,
                    }),
                  );

                  Navigator.pop(context);
                }catch(e){
                  setState(() {
                    isValid = false;
                    error = "Error connecting to server";
                  });
                }
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

