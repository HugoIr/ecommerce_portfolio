import 'package:flutter/material.dart';

import 'package:funesia_clone/services/auth/auth_service.dart';

class SignOut extends StatelessWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Out"),
        backgroundColor: Colors.grey[500],
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            await AuthService.signOut();
            Navigator.popUntil(context, ModalRoute.withName("/"));
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300]),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Sign Out")),
        ),
      ),
    );
  }
}
