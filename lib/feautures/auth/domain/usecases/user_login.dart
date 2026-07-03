import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/feautures/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserLogin implements Usecase <User,User_Login_params>{
      final AuthRepository authRepository;
    const UserLogin(this.authRepository);
    
  @override
  Future<Either<Failures, User>> call(User_Login_params params) async {
    return await authRepository.loginWithEmailPassowrd(password: params.password, email: params.email);


  }




}
class User_Login_params{
  final String email;
  final String password;

  User_Login_params({required this.email, required this.password});
}