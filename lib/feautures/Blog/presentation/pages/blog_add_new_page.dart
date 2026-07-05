import 'package:blog_app/core/theme/app_pallette.dart';
import 'package:blog_app/feautures/Blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BlogAddNewPage extends StatefulWidget {
  const BlogAddNewPage({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (context) => const BlogAddNewPage());

  @override
  State<BlogAddNewPage> createState() => _BlogAddNewPageState();
}

class _BlogAddNewPageState extends State<BlogAddNewPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopic = [];
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 15),
              DottedBorder(
                options: RectDottedBorderOptions(
                  color: Colors.red,
                  dashPattern: [10, 4],
                  strokeCap: StrokeCap.round,
                ),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.folder_open, size: 40),
                      SizedBox(height: 25),
                      Text(
                        "Select Your Image",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Business', 'Programming', 'Entertainment']
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopic.contains(e)) {
                                    selectedTopic.remove(e);
                                    //if again tapped same thing remove that
                                  } else {
                                    selectedTopic.add(
                                      e,
                                    ); //to add what the user is selected to a list for futher futrure dbms use
                                  }
                                  setState(() {});
                                },

                                child: Chip(
                                  label: Text(e),
                                  color: (selectedTopic.contains(e)
                                      ? WidgetStatePropertyAll(
                                          AppPallete.gradient1,
                                        )
                                      : null),
                                  side: const BorderSide(
                                    color: AppPallete.backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 10),
              BlogEditor(
                controller: titleController,
                hintText: 'Blog Title',
                maxLines: 3,
              ),
              const SizedBox(height: 10),

              BlogEditor(
                controller: contentController,
                hintText: 'Blog Content',
                maxLines: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
