import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'user.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  const ProfilePage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Page',
          style: GoogleFonts.inter(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100, shape: BoxShape.circle),
              child: Icon(
                Icons.person_sharp,
                size: 70,
                color: Colors.blueGrey.shade800,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              name,
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                  onPressed: () {
                    context.goNamed('edit_profile',
                        pathParameters: {'name': name},
                        extra: User(name, 'dummy@email.com'));
                  },
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
