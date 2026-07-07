// import 'dart:io';

// import 'package:blog_app/core/errors/exceptions.dart';
// import 'package:blog_app/core/errors/failures.dart';
// import 'package:blog_app/core/network/connection_checker.dart';
// import 'package:blog_app/feautures/Blog/data/datasources/blog_local_datasource.dart';
// import 'package:blog_app/feautures/Blog/data/datasources/blog_remote_data_source.dart';
// import 'package:blog_app/feautures/Blog/data/models/blog_model.dart';
// import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart';
// import 'package:blog_app/feautures/Blog/domain/repositories/blog_repositories.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:uuid/uuid.dart'; //implement blog repo coming from domain layer

// class BlogRepoImpl implements BlogRepositories {
//   final BlogRemoteDataSource blogRemoteDataSource;
//   final BlogLocalDatasource blogLocalDatasource;
//   final ConnectionChecker connectionChecker;
//   BlogRepoImpl(
//     this.blogRemoteDataSource,
//     this.blogLocalDatasource,
//     this.connectionChecker,
//   );

//   @override
//   Future<Either<Failures, Blog>> uploadBlog({
//     required File image,
//     required String title,
//     required String content,
//     required String posterId,
//     required List<String> topics,
//   }) async {
//     try {
//       if (!(await connectionChecker.isConnected)) {
//         return left(Failures("NO internet connection"));
//       }
//       BlogModel blogModel = BlogModel(
//         id: Uuid().v1(),
//         imageUrl: '',
//         posterId: posterId,
//         content: content,
//         title: title,
//         topics: topics,
//         updatedAt: DateTime.now(),
//       );
//       //the below thing is to get imageurl from supabase

//       final imageUrl = await blogRemoteDataSource.uploadBlogImage(
//         image: image,
//         blog: blogModel,
//       );
//       blogModel = blogModel.copyWith(imageUrl: imageUrl);
//       final uploadedblog = await blogRemoteDataSource.uploadBlog(blogModel);
//       return right(uploadedblog);
//       //this is what we return when our function is in success mode
//     } on ServerExceptions catch (e) {
//       return left(Failures(e.toString()));
//       // TODO
//     }
//   }

//   @override
//   Future<Either<Failures, List<Blog>>> getAllBlogs() async {
//     try {
//       if (!(await connectionChecker.isConnected)) {
//       final blogs=blogLocalDatasource.loadBlogs();
//       return right(blogs);

//       }
//       final blogs = await blogRemoteDataSource.getAllBlogs();
//       blogLocalDatasource.uploadLocalBlogs(blogs:blogs );
      
//       return right(blogs);
//     } catch (e) {
//       return left(Failures(e.toString()));
//     }
//   }
// }


// /*

// copyWith() is used to create a new model with only a few fields changed while keeping all the other
//  fields the same, which is a clean and safe way to work with immutable objects in Flutter.

//  */
import 'dart:io';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/feautures/Blog/data/datasources/blog_local_datasource.dart';
import 'package:blog_app/feautures/Blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/feautures/Blog/data/models/blog_model.dart';
import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart';
import 'package:blog_app/feautures/Blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepoImpl implements BlogRepositories {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDatasource blogLocalDatasource;
  final ConnectionChecker connectionChecker;

  BlogRepoImpl(
    this.blogRemoteDataSource,
    this.blogLocalDatasource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!(await connectionChecker.isConnected)) {
        return left(Failures("NO internet connection"));
      }

      BlogModel blogModel = BlogModel(
        id: Uuid().v1(),
        imageUrl: '',
        posterId: posterId,
        content: content,
        title: title,
        topics: topics,
        updatedAt: DateTime.now(),
      );

      // Upload image to Supabase Storage
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerExceptions catch (e) {
      return left(Failures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<Blog>>> getAllBlogs() async {
    try {
      // No internet -> Load from Hive
      if (!(await connectionChecker.isConnected)) {
        final blogs = blogLocalDatasource.loadBlogs();
        return right(blogs);
      }

      // Internet available -> Load from Supabase
      final blogs = await blogRemoteDataSource.getAllBlogs();

      // Save blogs locally in Hive
       blogLocalDatasource.uploadLocalBlogs(
        blogs: blogs,
      );

      return right(blogs);
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}

/*

copyWith() is used to create a new model with only a few fields changed
while keeping all the other fields the same, which is a clean and safe
way to work with immutable objects in Flutter.

*/