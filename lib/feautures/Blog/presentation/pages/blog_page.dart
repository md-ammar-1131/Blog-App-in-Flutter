import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallette.dart';
import 'package:blog_app/core/utilities/show_snakbar.dart';
import 'package:blog_app/feautures/Blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/feautures/Blog/presentation/bloc/blog_event.dart';
import 'package:blog_app/feautures/Blog/presentation/pages/blog_add_new_page.dart';
import 'package:blog_app/feautures/Blog/presentation/pages/colors_card.dart';
import 'package:blog_app/feautures/Blog/presentation/widgets/blog_card.dart';
// import 'package:blog_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllblogs());
  }

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
      //BLOG SHOWING-----------------------------------------------------------
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogSuccessDisplay) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCart(
                  blog: blog,
                  color: colors[index % colors.length],
                );
              },
              itemCount: state.blogs.length,
            );
          }
          return SizedBox(height: 60);
        },
      ),
    );
  }
}
