import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

// cubit for signin & signup
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  //for signin
  Future<void> signinUser(
      {required String email, required String password}) async {
    //when this code is excuted show loading screen
    emit(LoginLoading());
    //check this code using try and catch
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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

  //for signup
  Future<void> signupUser(
      {required String email, required String password}) async {
    emit(SignupLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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

  //this onChange tell me every state in debug console it work only for cubit
  /* @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(change);
  }*/
}
