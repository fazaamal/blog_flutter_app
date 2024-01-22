import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogPage extends StatelessWidget {
  final String? username;
  final Blog blog;

  const BlogPage({Key? key, required this.blog, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
        actions: [
          username == blog.username ? IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final response = await http.delete(
                Uri.parse('http://localhost:3000/blogs/${blog.id}'),
              );

              if (response.statusCode >= 200 && response.statusCode < 300) {
                // Blog deleted successfully
                print('Blog deleted!');

                // ignore: use_build_context_synchronously
                Navigator.pop(context, {
                  'deleted': true,
                  'id': blog.id,
                });
              } else {
                // Error deleting blog
                print('Error deleting blog: ${response.statusCode}');
              }
            },
          ) : Container(),
        ],
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
  final String id;
  final String username;

  Blog({
    required this.title,
    required this.content,
    required this.author,
    required this.id,
    required this.username,
  });
}
