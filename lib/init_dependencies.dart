import 'package:blog_app/core/secrets/secrets.dart';
import 'package:blog_app/feautures/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/feautures/auth/data/repositories/auth_reposit_impl.dart';
import 'package:blog_app/feautures/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_Sign_up.dart';
import 'package:blog_app/feautures/auth/domain/usecases/user_login.dart';
import 'package:blog_app/feautures/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show Supabase, SupabaseClient;

//now registering the depencdency with getit
final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth(); //registered dependencies are called here
  //FIRSTLY PULL SUPABSE FROM MAIN TO HERE SO THAT SERVICELOACTOR CAN GET IT FROM HERE DIRECTY

  final supabase = await Supabase.initialize(
    url: Secrets.supabaseUrl,
    anonKey: Secrets.supabaseAnon,
  );
  //register factory every time new - wherenver you ask a new instance is created
  //need to be created on demand not so general
  ////the below getit will give the same instance or we can say it will make a single instrncce of supabase
  ///
  ///
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    //we are passign generic type of this instance so that furthre taking of this will become easier
    () => AuthRemoteDataSourceImplementation(serviceLocator<SupabaseClient>()),
  );
  //every single time the new implementation of auth remote data source database client
  //HOW it sees authimplement it needs supabase clinea an we passed same type object this client he searhces this supabase cliend and take this and put it here we are not rewuired to mention the type it will search and pastr it here

  //wont b accesbile outside this file

  //now for auth repository implementation we will register to getit service locator
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositImpl(serviceLocator<AuthRemoteDataSource>()),
  );

  //USER SIGNUP SERVICE LOACTOR;
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  //authbloc one state as one state of bloc is only requried at particluar time so noe new instance is required so lazy singleton reigisteratoin isued here

  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignUp: serviceLocator(), userLogin: serviceLocator()),
  );

  //to use the dependency we must need to first register that depe.. here and then calling or using that dependency becomes easier like we have done by dircly cally serivcelocator();
}
