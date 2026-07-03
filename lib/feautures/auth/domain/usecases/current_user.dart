import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/feautures/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements Usecase<User,NoParams>{
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failures, User>> call( NoParams params) async {
    return await authRepository.currentUser();
    
  }


}//no params succes return user
