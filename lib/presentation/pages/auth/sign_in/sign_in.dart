import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/auth/auth_bloc.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/pages/sign_up/sign_up.dart';

class SignIn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build signup");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
              ),
              space(),
              TextFormField(
                controller: passwordController,
              ),
              space(),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context)
                        ..add(SignInWithEmailPasswordEvent(
                            email: emailController.text,
                            password: passwordController.text));
                      print("success");
                    }
                  },
                  child: Text("Sign In")),
              space(),
              Text.rich(TextSpan(children: [
                TextSpan(text: "Belum punya akun? "),
                WidgetSpan(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => SignUp()));
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  child: Text(
                    "Buat akun",
                    style: TextStyle(color: Colors.red[700]),
                  ),
                ))
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
