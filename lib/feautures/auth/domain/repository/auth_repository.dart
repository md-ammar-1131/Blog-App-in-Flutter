import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/feautures/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

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
  //  THE ABOVE TWO FUNCTION WILL DERIVE THE USER DATA FROM THE SUPABASE DATABASE SERVER WHICH IS ASYNCHRONOUS OR TAKE TAIME AND SO WE ARE USING FUTURE FUNNCTION FOT HIS 
  // if success we will return user model
}
