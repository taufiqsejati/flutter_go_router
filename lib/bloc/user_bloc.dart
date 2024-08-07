import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services.dart';
import '../user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserSignedOut()) {
    on<SignIn>((event, emit) async {
      if (state is UserSignedOut) {
        String? token =
            Services.getToken(email: event.email, password: event.password);

        if (token != null) {
          User? user = Services.getUser(email: event.email, token: token);

          if (user != null) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString('email', event.email);
            pref.setString('token', token);

            emit(UserSignedIn(user));
          }
        }
      }
    });
    on<SignOut>((event, emit) async {
      if (state is UserSignedIn) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove('email');
        pref.remove('token');

        emit(UserSignedOut());
      }
    });
    on<CheckSignInStatus>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? email = pref.getString('email');
      String? token = pref.getString('token');

      if (email != null && token != null) {
        bool tokenValid = Services.isTokenValid(token);
        if (tokenValid) {
          User? user = Services.getUser(email: email, token: token);
          if (user != null) {
            emit(UserSignedIn(user));
          }
        }
      }
    });
  }
}
