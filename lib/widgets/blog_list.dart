import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlogList extends StatelessWidget {
  const BlogList({super.key});

  @override
  Widget build( BuildContext context ) {
    return FutureBuilder(
      future: http.get(Uri.parse('http://localhost:3000/blogs')),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<dynamic> blogs = jsonDecode(snapshot.data!.body);
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(blogs[index]['imageUrl'], width: 100, fit: BoxFit.cover,),
                title: Text(blogs[index]['title']),
                subtitle: Text(blogs[index]['author']),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}