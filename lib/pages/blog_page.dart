import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  final Blog blog;

  const BlogPage({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pop(context);
        //       // Navigator.push(
        //       //   context,
        //       //   MaterialPageRoute(builder: (context) => const LoginPage()),
        //       // );
        //     },
        //   ),
        // ],
      ),
      body: 
        SingleChildScrollView(
          child:       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'By ${blog.author}',
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Text(
              blog.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ));
  }
}

class Blog {
  final String title;
  final String content;
  final String author;

  Blog({
    required this.title,
    required this.content,
    required this.author,
  });
}
