import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/feautures/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/feautures/auth/data/models/user_models.dart';
import 'package:blog_app/feautures/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositImpl implements AuthRepository {
  // Dependency Injection
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositImpl(this.remoteDataSource, this.connectionChecker);
  @override
  Future<Either<Failures, User>> currentUser() async {
    try {
      //AGAR MAIN DOBARA  APP PE AAOUN TO JO LAST LOGGED IN USER THA WO ALREADY AGAIN LGOGED IN HO JAYE
      if (!(await connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failures('user not logged in'));
        } else {
          return right(
            UserModels(
              name: '',
              email: session.user.email??'',//if email  is not present return empty string 
              id: session.user.id,
            ),
          );
        }
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failures('User Not logged in!'));
      }

      return right(user);
    } on ServerExceptions catch (e) {
      throw (Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> loginWithEmailPassowrd({
    required String password,
    required String email,
  }) async {
    return _getUser(
      () => remoteDataSource.logInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failures, User>> signupWithEmailPassword({
    required String name,
    required String password,
    required String email,
  }) async {
    return _getUser(
      () => remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  // Common handler for login/signup
  Future<Either<Failures, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!(await connectionChecker.isConnected)) {
        left(Failures('No internet Connection'));
      }
      final user = await fn();

      return right(user);
    }
    // Supabase Auth errors
    on sb.AuthException catch (e) {
      return left(Failures(e.message));
    }
    // Your custom server exceptions
    on ServerExceptions catch (e) {
      return left(Failures(e.message));
    }
    // Any unexpected exception
    catch (e) {
      return left(Failures(e.toString()));
    }
  }
 @override
Future<Either<Failures, void>> logout() async {
  try {
    await remoteDataSource.logout();
    return right(null);
  } catch (e) {
    return left(Failures(e.toString()));
  }
}
  




  
}
// // import 'package:blog_app/core/errors/exceptions.dart';
// // import 'package:blog_app/core/errors/failures.dart';
// // import 'package:blog_app/feautures/auth/data/datasources/auth_remote_data_source.dart';
// // import 'package:blog_app/feautures/auth/domain/entities/user.dart';
// // import 'package:blog_app/feautures/auth/domain/repository/auth_repository.dart';
// // import 'package:fpdart/src/either.dart';

// // class AuthRepositImpl implements AuthRepository {
// //   //this is signup function implementaion
// //   final AuthRemoteDataSource remoteDataSource;

// //   AuthRepositImpl(this.remoteDataSource);
// //   @override
// //   Future<Either<Failures, User>> loginWithEmailPassowrd({
// //     required String password,
// //     required String email,
// //   }) async {
// //     try {
// //       final user = await remoteDataSource.logInWithEmailPassword(
// //         email: email,
// //         password: password,
// //       );
// //       return right(user);
// //     } on ServerExceptions catch (e) {
// //       //if server exceotion we will return left
// //       return left(Failures(e.message)); //we are returning failure if failder this ting is common in each stae working

// //     }




// //   }

// //   @override
// //   Future<Either<Failures, User>> signupWithEmailPassword({
// //     required String name,
// //     required String password,
// //     required String email,
// //   }) async {
// //     try {
// //       final user = await remoteDataSource.signUpWithEmailPassword(
// //         name: name,
// //         email: email,
// //         password: password,
// //       );
// //       return right(user);
// //     } on ServerExceptions catch (e) {
// //       return left(Failures(e.message)); //we are returning failure
// //     }
// //   }
// //  
// // }

// import 'package:blog_app/core/errors/exceptions.dart';
// import 'package:blog_app/core/errors/failures.dart';
// import 'package:blog_app/feautures/auth/data/datasources/auth_remote_data_source.dart';
// import 'package:blog_app/feautures/auth/domain/entities/user.dart';
// import 'package:blog_app/feautures/auth/domain/repository/auth_repository.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthRepositImpl implements AuthRepository {
//   // Repository depends on the Remote Data Source.
//   // Dependency Injection is used here.
//   final AuthRemoteDataSource remoteDataSource;

//   AuthRepositImpl(this.remoteDataSource);

//   @override
//   Future<Either<Failures, User>> loginWithEmailPassowrd({
//     required String password,
//     required String email,
//   }) async {
//     // Instead of repeating try-catch here,
//     // we pass the login function to _getUser().
//     return _getUser(
//       () => remoteDataSource.logInWithEmailPassword(
//         email: email,
//         password: password,
//       ),
//     );
//   }

//   @override
//   Future<Either<Failures, User>> signupWithEmailPassword({
//     required String name,
//     required String password,
//     required String email,
//   }) async {
//     // Same idea here.
//     // Pass signup function to the common handler.
//     return _getUser(
//       () => remoteDataSource.signUpWithEmailPassword(
//         name: name,
//         email: email,
//         password: password,
//       ),
//     );
//   }

//   // =========================================================================
//   // COMMON FUNCTION
//   // =========================================================================
//   //
//   // Future<User> Function() fn
//   //
//   // Means:
//   // "Give me any function that returns Future<User>"
//   //
//   // Examples:
//   //
//   // () => remoteDataSource.logInWithEmailPassword(...)
//   //
//   // OR
//   //
//   // () => remoteDataSource.signUpWithEmailPassword(...)
//   //
//   // Both return Future<User>, so both can be passed.
//   //
//   // This removes duplicate try-catch blocks.
//   //
//   // This follows:
//   // 1. DRY Principle (Don't Repeat Yourself)
//   // 2. Clean Architecture
//   // 3. Single Responsibility Principle
//   //
//   Future<Either<Failures, User>> _getUser(
//     Future<User> Function() fn,
//   ) async {
//     try {
//       // Execute whichever function was passed.
//       final user = await fn();

//       // Success => Right
//       return right(user);
//     } on sb.AuthException catch(e){} ServerExceptions catch (e) {
//       // Convert Data Layer exception
//       // into Domain Layer Failure.

//       return left(Failures(e.message));
//     }
//   }
// }