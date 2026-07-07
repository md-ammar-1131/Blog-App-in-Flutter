// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart' show Blog;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog_app/feautures/Blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/feautures/Blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/feautures/Blog/presentation/bloc/blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadblog, required GetAllBlogs getAllblogs})
    : _uploadBlog = uploadblog,
      _getAllBlogs = getAllblogs,
      super(BlogInitial()) {
    //whenever we receive any blog event what i will do is
    //display a loading indiactor first of all so loading state not reqd for every state this will work fro any event called
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<blogUpload>(_onBlogUpload);
    on<BlogFetchAllblogs>(_onfetchAllBlogs);
  }
  void _onBlogUpload(blogUpload event, Emitter<BlogState> emit) async {
    final reslt = await _uploadBlog(
      UploadParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );
    reslt.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogSuccessUpload()),
    );
  } //why this funnc??

  void _onfetchAllBlogs(
    BlogFetchAllblogs event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogs(NoParams());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogSuccessDisplay(blogs: r)),
    );
  }
}
