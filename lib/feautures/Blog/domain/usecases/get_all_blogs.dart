import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart';
import 'package:blog_app/feautures/Blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepositories blogRepositories;

  GetAllBlogs(this.blogRepositories);

  @override
  Future<Either<Failures, List<Blog>>> call(NoParams params) async {
    return await blogRepositories.getAllBlogs();
  }
}
