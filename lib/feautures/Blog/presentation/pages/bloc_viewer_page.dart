// import 'package:blog_app/core/utilities/calc_reading_time.dart';
// import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart';
// import 'package:flutter/material.dart';

// class BlocViewerPage extends StatelessWidget {
//   final Blog blog;
//   const BlocViewerPage({super.key, required this.blog});

//   static route(Blog blog) {
//     return MaterialPageRoute(builder: (context) => BlocViewerPage(blog: blog));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               blog.title,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'By ${blog.posterName}',
//             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
//           ),
//                     const SizedBox(height: 5),

//         Text('${blog.updatedAt}.${calcReadingTime(blog.content)} ')
//         ],
//       ),
//     );
//   }
// }

import 'package:blog_app/core/utilities/calc_reading_time.dart';
import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlocViewerPage extends StatelessWidget {
  final Blog blog;

  const BlocViewerPage({super.key, required this.blog});

  static Route route(Blog blog) {
    return MaterialPageRoute(builder: (_) => BlocViewerPage(blog: blog));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image
              Hero(
                tag: blog.id,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                  child: Image.network(
                    blog.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Topics
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: blog.topics
                          .map(
                            (topic) => Chip(
                              label: Text(topic),
                              backgroundColor: Colors.blue.shade100,
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      blog.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Author
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            blog.posterName!,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    // Date + Time + Reading Time
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),

                        Text(
                          DateFormat('dd MMM yyyy').format(blog.updatedAt),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          "•",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Icon(
                          Icons.access_time,
                          size: 18,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          DateFormat('hh:mm a').format(blog.updatedAt),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),

                        const Spacer(),

                        const Icon(
                          Icons.menu_book_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          "${calcReadingTime(blog.content)} min read",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Divider(),

                    const SizedBox(height: 20),

                    // Content
                    SelectableText(
                      blog.content,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.8,
                        letterSpacing: .2,
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
