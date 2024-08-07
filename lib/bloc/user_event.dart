part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SignIn extends UserEvent {
  final String email;
  final String password;

  SignIn({required this.email, required this.password});

  List<Object> get props => [email, password];
}

class SignOut extends UserEvent {}

class CheckSignInStatus extends UserEvent {}
