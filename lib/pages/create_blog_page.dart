
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import '../auth/auth_manager.dart';

class CreateBlogPage extends StatefulWidget {
  final String author;

  const CreateBlogPage({super.key, required this.author});

  @override
  _CreateBlogPageState createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> _publishBlog() async {
    final String title = _titleController.text;
    final String content = _contentController.text;

    final response = await http.post(

      Uri.parse('http://localhost:3000/blogs'),
      body: jsonEncode({
        'title': title,
        'content': content,
        'author': widget.author,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Blog published successfully
      print('Blog published!');

      Navigator.pop(context, true);
    } else {
      // Error publishing blog
      print('Error publishing blog: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Blog'),
      ),
      body: 
        SingleChildScrollView(
          child:
        Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              maxLines: null, // Set maxLines to null for multiline
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _publishBlog,
              child: const Text('Publish'),
            ),
          ],
        ),
      ),

        )
    );
  }
}
