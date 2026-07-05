import 'package:blog_app/feautures/Blog/presentation/pages/blog_add_new_page.dart';
import 'package:blog_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('blog app'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, BlogAddNewPage.route());
            },
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
    );
  }
}
