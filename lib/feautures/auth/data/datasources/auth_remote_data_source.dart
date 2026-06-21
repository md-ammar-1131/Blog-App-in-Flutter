//creating interfacr for auth remote database for having a stric contract to flow
// import 'package:blog_app/core/errors/failures.dart';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/feautures/auth/data/models/user_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModels> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModels> logInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final SupabaseClient
  supabaseClient; //THIS FILE WILL REGAIN DATA FROM THE SUPABASE SERVER
  //no dependency between class and supabase  and second reaseonf is of testing why we are not directly passing client but taking in constructor

  AuthRemoteDataSourceImplementation(this.supabaseClient);

  @override
  Future<UserModels> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      ); //like uidai we have dob and other things aadhar no
      if (response.user == null) {
        throw ServerExceptions('user is null');
      }
      return UserModels.fromJson(response.user!.toJson());
      //we are foing to do this if only user is not null
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<UserModels> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    //MAKING USER AND GETTINF RESOPNSE FROM SUPABASE AND RETURNING SERVER EXCEPTION IF NULL ELSE USER ID IS RETURNED FROM SUPABASE--=

    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      ); //like uidai we have dob and other things aadhar no
      if (response.user == null) {
        throw ServerExceptions('user is null');
      }
      return UserModels.fromJson(response.user!.toJson());
      //we are foing to do this if only user is not null
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
