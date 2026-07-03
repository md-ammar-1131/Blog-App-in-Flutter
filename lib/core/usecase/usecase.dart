import 'package:blog_app/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';
abstract interface class Usecase <SucessType,Params>{
  //expose is the work of this class
  Future<Either<Failures,SucessType>>call(Params params);

}
class NoParams{
  
}