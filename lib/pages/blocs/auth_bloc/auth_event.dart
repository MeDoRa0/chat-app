part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SighninEvent extends AuthEvent {
  final String email;
  final String password;

  SighninEvent({required this.email, required this.password});
}

class SighupEvent extends AuthEvent {
  final String email;
  final String password;

  SighupEvent({required this.email,required this.password});
}
