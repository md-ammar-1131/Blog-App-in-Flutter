import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feautures/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogout implements Usecase<void, NoParams> {
  final AuthRepository repository;

  UserLogout(this.repository);

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return repository.logout();
  }
}