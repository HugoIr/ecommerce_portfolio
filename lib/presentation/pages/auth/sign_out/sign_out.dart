import 'package:flutter/material.dart';

import 'package:funesia_clone/services/auth/auth_service.dart';

class SignOut extends StatelessWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await AuthService.signOut();
              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
            child: Text("Sign Out")),
      ),
    );
  }
}
