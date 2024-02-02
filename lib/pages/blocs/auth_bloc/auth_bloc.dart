import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      //check the coming event, if it is signinevent
      if (event is SighninEvent) {
        emit(LoginLoading());
        //check this code using try and catch
        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          //if login success
          emit(LoginSuccess());

          //if login failed
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LogingFailuer(erorrMessage: 'user not found'));
          } else if (e.code == 'wrong-password') {
            emit(LogingFailuer(erorrMessage: 'wrong password'));
          }
        } catch (e) {
          emit(LogingFailuer(erorrMessage: 'something went wrong'));
        }
      }
      //------------------------------------------------------------------------------
      //if the coming event is signup event
      else if (event is SighupEvent) {
        emit(SignupLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(SignupSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            emit(SignupFailuer(erorrMessage: 'email already in use'));
          } else if (e.code == 'weak-password') {
            emit(SignupFailuer(erorrMessage: 'weak password'));
          } else if (e.code == "The-email-address-is-badly-formatted") {
            emit(SignupFailuer(
                erorrMessage: 'The email address is badly formatted'));
          }
        } catch (e) {
          emit(SignupFailuer(erorrMessage: 'there was error please try again'));
        }
      }
    });
  }
  //this onTransition tell me every state in debug console it work only for bloc
  /* @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print(transition);
  }*/
}
