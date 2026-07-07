import 'dart:io';

import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart';
import 'package:blog_app/feautures/Blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/src/either.dart';

class UploadBlog implements Usecase<Blog, UploadParams> {
  final BlogRepositories blogRepositories;

  UploadBlog(this.blogRepositories);
  @override
  Future<Either<Failures, Blog>> call(UploadParams params) async {
    return await blogRepositories.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
    throw UnimplementedError();
  }
}

class UploadParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
