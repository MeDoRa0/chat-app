part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class SignupLoading extends AuthState {}
class SignupSuccess extends AuthState {}
class SignupFailuer extends AuthState {
 String erorrMessage;
 SignupFailuer({required this.erorrMessage});
}
class LoginSuccess extends AuthState {}

class LogingFailuer extends AuthState {
  String erorrMessage;
  LogingFailuer({required this.erorrMessage});
}

class LoginLoading extends AuthState {}

