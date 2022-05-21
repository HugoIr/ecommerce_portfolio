import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/user/user_bloc.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/pages/auth/sign_out/sign_out.dart';

SizedBox spaceHorizontal() {
  return SizedBox(
    width: 24,
  );
}

Column opsiPesananSaya({required String asset, required String text}) {
  return Column(
    children: [
      Image.asset(
        asset,
        width: 24,
        height: 24,
      ),
      SizedBox(
        height: 14,
      ),
      Container(
        width: 55,
        child: Text(
          text,
          style: TextStyle(fontSize: 11),
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}

Widget btnBukaStore() {
  return BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      if (state is UserLoaded && !state.isSeller) {
        return Column(
          children: [
            space(),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color.fromARGB(255, 229, 161, 60)),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: -5,
                      left: 16,
                      child: Image.asset(
                        "assets/profile/kitty.png",
                        width: 44,
                        height: 44,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Buka Store Sekarang!",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 16),
                        alignment: Alignment.centerRight,
                        child:
                            rightArrow(color: Colors.white, widthBorder: 0.75))
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return SizedBox();
      }
    },
  );
}

SizedBox rowIdentity(context, String name, String? email, String? phoneNumber) {
  return SizedBox(
    height: 100,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.yellow[600]),
          child: Image.asset(
            "assets/profile/smile_face.png",
            color: Colors.blueAccent[700],
            width: 54,
            height: 54,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              email ?? "",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 4,
            ),
            (phoneNumber != null)
                ? Text(
                    phoneNumber,
                    style: TextStyle(fontSize: 12),
                  )
                : SizedBox(),
          ],
        ),
        Spacer(
          flex: 2,
        ),
        InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (builder) => SignOut())),
          child: Container(
            height: double.infinity,
            alignment: Alignment.topCenter,
            child: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 110, 110, 110),
            ),
          ),
        )
      ],
    ),
  );
}
