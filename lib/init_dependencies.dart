import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/secrets/secrets.dart';

import 'package:blog_app/feautures/Blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/feautures/Blog/data/repositories/blog_repo_impl.dart';
import 'package:blog_app/feautures/Blog/domain/repositories/blog_repositories.dart';
import 'package:blog_app/feautures/Blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/feautures/Blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/feautures/Blog/presentation/bloc/blog_bloc.dart';

import 'package:blog_app/feautures/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/feautures/auth/data/repositories/auth_reposit_impl.dart';
import 'package:blog_app/feautures/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/feautures/auth/domain/usecases/current_user.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_Sign_up.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_login.dart';
import 'package:blog_app/feautures/auth/presentation/bloc/auth_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show Supabase, SupabaseClient;

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: Secrets.supabaseUrl,
    publishableKey: Secrets.supabaseAnon,
  );

  serviceLocator.registerLazySingleton<SupabaseClient>(
    () => supabase.client,
  );

  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  serviceLocator.registerLazySingleton(
    () => InternetConnection(),
  );

  serviceLocator.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator<InternetConnection>(),
    ),
  );

  _initAuth();
  _initBlog();
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplementation(
      serviceLocator<SupabaseClient>(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositImpl(
      serviceLocator<AuthRemoteDataSource>(),
      serviceLocator<ConnectionChecker>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator<UserSignUp>(),
      userLogin: serviceLocator<UserLogin>(),
      currentUser: serviceLocator<CurrentUser>(),
      appUserCubit: serviceLocator<AppUserCubit>(),
    ),
  );
}

void _initBlog() {
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImplmn(
      serviceLocator<SupabaseClient>(),
    ),
  );

  serviceLocator.registerFactory<BlogRepositories>(
    () => BlogRepoImpl(
      serviceLocator<BlogRemoteDataSource>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UploadBlog(
      serviceLocator<BlogRepositories>(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetAllBlogs(
      serviceLocator<BlogRepositories>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      uploadblog: serviceLocator<UploadBlog>(),
      getAllblogs: serviceLocator<GetAllBlogs>(),
    ),
  );
}