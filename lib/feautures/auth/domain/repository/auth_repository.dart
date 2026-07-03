import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';
//auth repo will basically conatin abstract class saying that these funtions or class are must to be impelemtnt like main chef or waiter that will implementd jn aut repo impl of rpositories folder or repo layer

abstract interface class AuthRepository {
  //failure and success of login must be handled by this autrepo
  //fpdart is used: specify what the return data type should be
  //either fail or succes what is retured
  Future<Either<Failures, User>> signupWithEmailPassword({
    required String name,
    required String password,
    required String email,
  });
  Future<Either<Failures, User>> loginWithEmailPassowrd({
    required String password,
    required String email,
  
  });
  Future<Either<Failures,User>>currentUser();
  //  THE ABOVE TWO FUNCTION WILL DERIVE THE USER DATA FROM THE SUPABASE DATABASE SERVER WHICH IS ASYNCHRONOUS OR TAKE TAIME AND SO WE ARE USING FUTURE FUNNCTION FOT HIS 
  // if success we will return user model
}
