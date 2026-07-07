import 'package:blog_app/core/theme/app_pallette.dart';
import 'package:blog_app/core/utilities/calc_reading_time.dart';
import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart';
import 'package:blog_app/feautures/Blog/presentation/pages/bloc_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCart extends StatelessWidget {
  final Blog blog;
  final Color color;

  const BlogCart({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlocViewerPage.route(blog));//ye wala blog pass ker ke new page push kro 
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: blog.topics.map((topic) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(topic),
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              blog.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),

            //reading time
            Text(
              '${calcReadingTime(blog.content)} min',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
