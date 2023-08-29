import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatlyapp/bloc/auth_event.dart';
import 'package:chatlyapp/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthService authService;

  AuthBloc({required this.authService} ) : super(UnAuth()){
    on<SignInRequested>((event, state) async {
      emit(Loading());
      try{
        authService.signInWithEmailandPassword(event.email, event.password);
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    });
    on<SignUpRequested>((event, state) async {
      emit(Loading());
      try{
        authService.signUpWithEmailandPassword(event.email, event.password);
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    });
    on<SignOutRequested>((event, state) async {
      emit(Loading());
      try{
        authService.signOut();
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    });
  }
}