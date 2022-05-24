import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funesia_clone/common/utils/db_helper.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/firebase_options.dart';
import 'package:funesia_clone/presentation/components/blocs/auth/auth_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/user/user_bloc.dart';
import 'package:funesia_clone/presentation/components/cubits/pages/pages_cubit.dart';
import 'package:funesia_clone/presentation/pages/auth/sign_in/sign_in.dart';
import 'package:funesia_clone/presentation/pages/main_page/main_page.dart';
import 'package:funesia_clone/presentation/pages/sign_up/sign_up.dart';
import 'package:funesia_clone/services/auth/auth_service.dart';
import 'package:funesia_clone/services/product/product_service.dart';
import 'package:funesia_clone/services/user/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DBHelper.createTable();
  runApp(Main());
}

class Main extends StatelessWidget {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  UserBloc userBloc = UserBloc(
      userService: UserService(firebaseFirestore: FirebaseFirestore.instance));
  Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (create) => PagesCubit()),
          BlocProvider(
            create: (create) => AuthBloc(
              authService: AuthService(firebaseAuth: firebaseAuth),
              userService: UserService(firebaseFirestore: firebaseFirestore),
              userBloc: userBloc,
            ),
          ),
          BlocProvider(
            create: (create) => userBloc..add(GetUserInformationEvent()),
          ),
          BlocProvider(
              create: (create) => ForYouBloc(
                  productService: ProductService(),
                  userService:
                      UserService(firebaseFirestore: firebaseFirestore))
                ..add(GetForYouEvent())),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
            home: StreamBuilder<User?>(
                stream: firebaseAuth.authStateChanges(),
                builder: (context, snapshot) {
                  return (snapshot.hasData) ? MainPage() : SignIn();
                })
            // return StreamBuilder<User?>(
            //   stream: firebaseAuth.authStateChanges(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       print("snapshot ${snapshot.data}");
            //       return MainPage();
            //     }
            //     print("snapshot kosong");
            //     return SignUp();
            //   },
            // );

            ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User>();
    // print("firebaseuser ${firebaseUser.email}");
    // if (firebaseUser != null) {
    //   return MainPage();
    // }
    // return SignUp();
    // var isLoggedIn = false;
    // FirebaseAuth.instance.authStateChanges().listen((user) {
    //   if (user != null) {
    //     print("USER NOT NULL");
    //     isLoggedIn = true;
    //   } else {
    //     print("USER NULL");
    //     isLoggedIn = false;
    //   }
    // });
    // print("ISS LOGEIN $isLoggedIn");
    // if (isLoggedIn) {
    //   return MainPage();
    // } else {
    //   return SignUp();
    // }

    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("snapshot ${snapshot.data}");
          return MainPage();
        }
        return SignUp();
      },
    );
    return SignUp();
    // return BlocBuilder<AuthBloc, AuthState>(
    //   builder: (context, state) {
    //     print("state main: $state");
    //     print("state bool: ${state is LoggedInState}");
    //     if (state is LoggedInState) {
    //       print("state LoggedInState;");
    //       return MainPage();
    //     } else if (state is AuthInitial) {
    //       print("state signup;");
    //       // Navigator.pushReplacement(
    //       //     context, MaterialPageRoute(builder: (builder) => MainPage()));
    //       return SignUp();
    //     } else {
    //       print("state else ;");
    //       return Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }
}
