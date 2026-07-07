import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/cubits/app_user/app_user_state.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallette.dart';
import 'package:blog_app/core/utilities/pic_image.dart';
import 'package:blog_app/core/utilities/show_snakbar.dart';
import 'package:blog_app/feautures/Blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/feautures/Blog/presentation/bloc/blog_event.dart';
import 'package:blog_app/feautures/Blog/presentation/pages/blog_page.dart';
import 'package:blog_app/feautures/Blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final formKey = GlobalKey<FormState>();

  final List<String> topics = [
    'Technology',
    'Business',
    'Programming',
    'Entertainment',
  ];

  final List<String> selectedTopic = [];

  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopic.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;

      context.read<BlogBloc>().add(
        blogUpload(
          posterId: posterId,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          image: image!,
          topics: selectedTopic,
        ),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("New Blog"),
        actions: [
          IconButton(
            onPressed: uploadBlog,

            icon: const Icon(Icons.done_rounded),
          ),
        ],
        //FORMKEY WHY IS IT USED "FORM"
      ),
      body: SafeArea(
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.error);
            } else if (state is BlogSuccessUpload) {
              Navigator.pushAndRemoveUntil(
                context,
                BlogPage.route(),
                (route) => false,
              );
            }

            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),
              child: Form(
                key: formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Image Picker
                    image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              height: height * 0.28,
                              width: double.infinity,
                              child: Image.file(image!, fit: BoxFit.cover),
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                              options: RectDottedBorderOptions(
                                color: Colors.red,
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                              ),
                              child: SizedBox(
                                height: height * 0.22,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open_rounded,
                                      size: width * 0.12,
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      "Select Your Image",
                                      style: TextStyle(
                                        fontSize: width * 0.055,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                    SizedBox(height: height * 0.03),

                    /// Topics
                    Text(
                      "Select Topics",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: height * 0.015),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: topics.map((topic) {
                        final isSelected = selectedTopic.contains(topic);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedTopic.remove(topic);
                              } else {
                                selectedTopic.add(topic);
                              }
                            });
                          },
                          child: Chip(
                            label: Text(topic),
                            backgroundColor: isSelected
                                ? AppPallete.gradient1
                                : Colors.transparent,
                            side: BorderSide(
                              color: isSelected
                                  ? AppPallete.gradient1
                                  : Colors.grey.shade700,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: height * 0.03),

                    /// Blog Title
                    BlogEditor(
                      controller: titleController,
                      hintText: "Blog Title",
                      maxLines: 3,
                    ),

                    SizedBox(height: height * 0.025),

                    /// Blog Content
                    BlogEditor(
                      controller: contentController,
                      hintText: "Write your blog here...",
                      maxLines: 18,
                    ),

                    SizedBox(height: height * 0.04),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
