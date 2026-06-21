import 'package:blog_app/feautures/auth/domain/entities/user.dart';

class UserModels extends User{
  UserModels({required super.name, required super.email, required super.id});
  //takign email id name and hten passing to the super class that is enitites's user
  //liskov substitution is entity with  model and model with eneity replacement can occur easily
  

//wer will write json repson to user model
/*


Database (JSON)
      ↓
 DataSource
      ↓
 UserModel
      ↓
 Repository
      ↓
 User Entity
      ↓
 Domain/UI

 //again and again doing the same thing to get raw id password form supabase it wpasses through the user model and get converted easy good thing or good data
 
 
  */

factory UserModels.fromJson(Map<String,dynamic>map){
return UserModels(name: map['name']??'', email: map['email']?? '', id: map['id'] ??'');
}
}