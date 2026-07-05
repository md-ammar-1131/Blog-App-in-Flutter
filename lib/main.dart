
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/cubits/app_user/app_user_state.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/feautures/Blog/presentation/pages/blog_page.dart';

import 'package:blog_app/feautures/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feautures/auth/presentation/pages/login_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // FIX 1: Added await to ensure dependencies load before the app starts
  await initDependencies(); 
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Checking if user is already logged in on startup
    context.read<AuthBloc>().add(AuthUserLoggedIn());
  }

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
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        // FIX 2: Check against the State, not the Cubit
        return state is AppUserLoggedIn; 
      },
      builder: (context, isLoggedIn) {
        if (isLoggedIn) {
          // If true, show the home page center text
          return const BlogPage();
        }
        // If false, show the login page
        return const LoginPage();
      },
    );
  }
}
































// import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
// import 'package:blog_app/core/common/cubits/app_user/app_user_state.dart';
// import 'package:blog_app/core/theme/theme.dart';

// import 'package:blog_app/feautures/auth/presentation/bloc/auth_bloc.dart';
// import 'package:blog_app/feautures/auth/presentation/pages/login_page.dart';
// import 'package:blog_app/init_dependencies.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //for bindinf courrect iniitailiazation

//   initDependencies();
//   ////////////////////////////////////////////
//   runApp(
//     ///this is multibloc or bloc configuration
//     ///
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
//         BlocProvider(create: (_) => serviceLocator<AuthBloc>()),

//         // create: (context) => AuthBloc(
//         //   userSignUp: UserSignUp(
//         //     AuthRepositImpl(
//         //       AuthRemoteDataSourceImplementation(supabase.client),
//         //     ),
//         //   ),
//         // ),
//         //since we have already registerd auth bloc we are not reuied to do that big shit again we can directly use serviceloactor
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// ////////////////////////////////////////////////
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   void initState() {
//     super.initState();
//     context.read<AuthBloc>().add(AuthUserLoggedIn());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Blog App',
//       theme: AppTheme.darkthemeMode,
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<AppUserCubit, AppUserState, bool>(
//       selector: (state) {
//         return state is AppUserCubit;
//       },
//       builder: (context, isloggedIn) {
//         if (isloggedIn) {
//           return Scaffold(body: Center(child: Text("logged in")));
//         }
//         return const LoginPage();
//       },
//     );
//   }
// }

// // future first folder making approcah
// // core folder is going to coantin the properties teh overall app in common will follow like back color supabase link api secret...
// //now we will start our data layer on 11-6-26 11 pm
// //we will start data sources now


// //NOW 








// // uf user is not logged in  it will be an error else  it will move to home page 




// //WHAT IS DEPENDENCY INJECTION 