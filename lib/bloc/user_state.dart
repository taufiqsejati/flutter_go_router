part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserSignedOut extends UserState {}

class UserSignedIn extends UserState {
  final User user;

  UserSignedIn(this.user);

  List<Object> get props => [user];
}
