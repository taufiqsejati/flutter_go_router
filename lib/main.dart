import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'about_page.dart';
import 'edit_profile_page.dart';
import 'main_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginPage();
        }),
    GoRoute(
        path: '/',
        name: 'main_page',
        builder: (context, state) {
          return const MainPage();
        },
        routes: [
          GoRoute(
              path: 'about',
              name: 'about',
              builder: (context, state) {
                return const AboutPage();
              }),
          GoRoute(
              path: 'profile/:name',
              name: 'profile',
              builder: (context, state) {
                String name = state.pathParameters['name'] ?? 'no name';
                return ProfilePage(name: name);
              },
              routes: [
                GoRoute(
                    path: 'edit_profile',
                    name: 'edit_profile',
                    builder: (context, state) {
                      Object? object = state.extra;
                      if (object != null && object is User) {
                        return EditProfilePage(user: object);
                      } else {
                        return const EditProfilePage(
                            user: User('no name', 'no email'));
                      }
                    })
              ]),
        ])
  ], initialLocation: '/login', debugLogDiagnostics: true);
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
