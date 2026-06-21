
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feautures/auth/domain/entities/user.dart';
import 'package:blog_app/feautures/auth/domain/repository/auth_repository.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';


//this class is for passing the parameters to usersignup usecase

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failures, User>> call(UserSignUpParams params) async {
    return await authRepository.signupWithEmailPassword(
      name: params.name,
      password: params.password,
      email: params.email,
    );

  }
}

