import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pages//blog_page.dart';

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
                title: Text(blogs[index]['title']),
                subtitle: Text(blogs[index]['author']),
                onTap: () {

                  try {
                    print(blogs[index]['title']+' '+ blogs[index]['content']+ ' '+  blogs[index]['author']);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlogPage(blog: Blog(
                      title: blogs[index]['title'],
                      content: blogs[index]['content'],
                      author: blogs[index]['author'],
                    ))));
                  } catch (e) {
                    print(e);
                  }

                },

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