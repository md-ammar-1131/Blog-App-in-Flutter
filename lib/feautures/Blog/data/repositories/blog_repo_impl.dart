import 'dart:io';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/feautures/Blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/feautures/Blog/data/models/blog_model.dart';
import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart';
import 'package:blog_app/feautures/Blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart'; //implement blog repo coming from domain layer

class BlogRepoImpl implements BlogRepositories {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepoImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: Uuid().v1(),
        imageUrl: '',
        posterId: posterId,
        content: content,
        title: title,
        topics: topics,
        updatedAt: DateTime.now(),
      );
      //the below thing is to get imageurl from supabase

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedblog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedblog);
      //this is what we return when our function is in success mode
    } on ServerExceptions catch (e) {
      return left(Failures(e.toString()));
      // TODO
    }
  }

  @override
  Future<Either<Failures, List<Blog>>> getAllBlogs() async {
    try {
final blogs=await blogRemoteDataSource.getAllBlogs();
return right(blogs);




    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}


/*

copyWith() is used to create a new model with only a few fields changed while keeping all the other
 fields the same, which is a clean and safe way to work with immutable objects in Flutter.

 */