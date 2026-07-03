
import 'package:blog_app/core/common/entities/user.dart';


sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}
//state shows that user is logged out

//user is logged in 
final class AppUserLoggedIn extends AppUserState{
  final User user;

  AppUserLoggedIn(this.user);
  

}
//core cant depend on any other feautre but others can depenc d no core
