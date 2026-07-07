import 'dart:io';

import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepositories {
  Future<Either<Failures, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
  Future<Either<Failures,List<Blog>>>getAllBlogs();

}
