import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{

}
class Loading extends AuthState{
  @override
  List<Object> get props => [];

}

class UnAuth extends AuthState{
  @override
  List<Object> get props => [];

}