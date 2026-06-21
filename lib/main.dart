import 'package:blog_app/core/theme/theme.dart';

import 'package:blog_app/feautures/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feautures/auth/presentation/pages/login_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //for bindinf courrect iniitailiazation

  initDependencies();
  ////////////////////////////////////////////
  runApp(
    ///this is multibloc or bloc configuration
    ///
    MultiBlocProvider(
      providers: [
        BlocProvider(
          // create: (context) => AuthBloc(
          //   userSignUp: UserSignUp(
          //     AuthRepositImpl(
          //       AuthRemoteDataSourceImplementation(supabase.client),
          //     ),
          //   ),
          // ),
          //since we have already registerd auth bloc we are not reuied to do that big shit again we can directly use serviceloactor
          create: (context) => serviceLocator<AuthBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

////////////////////////////////////////////////
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkthemeMode,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

// future first folder making approcah
// core folder is going to coantin the properties teh overall app in common will follow like back color supabase link api secret...
//now we will start our data layer on 11-6-26 11 pm
//we will start data sources now


//NOW 













//WHAT IS DEPENDENCY INJECTION 