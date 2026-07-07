import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/secrets/secrets.dart';

// Hive
import 'package:blog_app/feautures/Blog/data/datasources/blog_local_datasource.dart';

// Blog
import 'package:blog_app/feautures/Blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/feautures/Blog/data/repositories/blog_repo_impl.dart';
import 'package:blog_app/feautures/Blog/domain/repositories/blog_repositories.dart';
import 'package:blog_app/feautures/Blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/feautures/Blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/feautures/Blog/presentation/bloc/blog_bloc.dart';

// Auth
import 'package:blog_app/feautures/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/feautures/auth/data/repositories/auth_reposit_impl.dart';
import 'package:blog_app/feautures/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/feautures/auth/domain/usecases/current_user.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_Sign_up.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_login.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_logout.dart';
import 'package:blog_app/feautures/auth/presentation/bloc/auth_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show Supabase, SupabaseClient;

final serviceLocator = GetIt.instance;

/// ===============================================================
/// Initializes every dependency used in the application.
/// This is the entry point of Dependency Injection.
/// ===============================================================
Future<void> initDependencies() async {
  // -------------------------------
  // Initialize Supabase
  // -------------------------------
  final supabase = await Supabase.initialize(
    url: Secrets.supabaseUrl,
    publishableKey: Secrets.supabaseAnon,
  );

  // -------------------------------
  // Initialize Hive
  // -------------------------------
  Hive.defaultDirectory =
      (await getApplicationDocumentsDirectory()).path;

  // Open the blogs box before registering it.
  final blogBox = await Hive.box(name:'blogs');

  // -------------------------------
  // Core Dependencies
  // -------------------------------

  // Supabase Client
  serviceLocator.registerLazySingleton<SupabaseClient>(
    () => supabase.client,
  );

  // Stores currently logged-in user
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  // Hive Box
  serviceLocator.registerLazySingleton<Box>(
    () => blogBox,
  );

  // Internet Checker Package
  serviceLocator.registerLazySingleton(
    () => InternetConnection(),
  );

  // Custom Connection Checker
  serviceLocator.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator<InternetConnection>(),
    ),
  );

  // Initialize Feature Dependencies
  _initAuth();
  _initBlog();
}

/// ===============================================================
/// Authentication Dependency Injection
/// ===============================================================
void _initAuth() {
  // Remote Data Source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplementation(
      serviceLocator<SupabaseClient>(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositImpl(
      serviceLocator<AuthRemoteDataSource>(),
      serviceLocator<ConnectionChecker>(),
    ),
  );

  // UseCases
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
  serviceLocator.registerFactory(
  () => UserLogout(
    serviceLocator<AuthRepository>(),
  ),
);

  // Bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userLogout: serviceLocator<UserLogout>(),
      userSignUp: serviceLocator<UserSignUp>(),
      userLogin: serviceLocator<UserLogin>(),
      currentUser: serviceLocator<CurrentUser>(),
      appUserCubit: serviceLocator<AppUserCubit>(),
      
    ),
 
  );
}

/// ===============================================================
/// Blog Dependency Injection
/// ===============================================================
void _initBlog() {
  // -------------------------------
  // Remote Data Source
  // -------------------------------
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImplmn(
      serviceLocator<SupabaseClient>(),
    ),
  );

  // -------------------------------
  // Local Data Source (Hive)
  // -------------------------------
  serviceLocator.registerFactory<BlogLocalDatasource>(
    () => BlogLocalDatasourceImpl(
      serviceLocator<Box>(),
    ),
  );

  // -------------------------------
  // Repository
  // -------------------------------
  serviceLocator.registerFactory<BlogRepositories>(
    () => BlogRepoImpl(
      serviceLocator<BlogRemoteDataSource>(),
      serviceLocator<BlogLocalDatasource>(),
      serviceLocator<ConnectionChecker>(),
    ),
  );

  // -------------------------------
  // UseCases
  // -------------------------------
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

  // -------------------------------
  // Bloc
  // -------------------------------
  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      uploadblog: serviceLocator<UploadBlog>(),
      getAllblogs: serviceLocator<GetAllBlogs>(),
    ),
  );
}