import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funesia_clone/presentation/components/blocs/user/user_bloc.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/profile/reusable_widget_profile.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/pages/auth/sign_out/sign_out.dart';
import 'package:funesia_clone/presentation/pages/seller/my_store.dart';
import 'package:path/path.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
                btnTokoSaya()
              ],
            ),
            space(),
            rowIdentity(context, "Budi Setiawan",
                FirebaseAuth.instance.currentUser?.email, "085123124324"),

            btnBukaStore(),
            SizedBox(
              height: 10,
            ),
            Divider(thickness: 2),
            SizedBox(
              height: 5,
            ),
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Purchases",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          opsiPesananSaya(
                            asset: "assets/profile/wallet.png",
                            text: "To Pay",
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          opsiPesananSaya(
                            asset: "assets/profile/shopping_bag.png",
                            text: "To Ship",
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          opsiPesananSaya(
                            asset: "assets/profile/van_cargo.png",
                            text: "To Receive",
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          opsiPesananSaya(
                            asset: "assets/profile/star.png",
                            text: "To Rate",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // BlocBuilder<UserBloc, UserState>(
            //   builder: (context, state) {
            //     if (state is UserLoaded && state.isSeller) {
            //       return InkWell(
            //         onTap: () {},
            //         child: Container(
            //           width: double.infinity,
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //           decoration: BoxDecoration(
            //             color: Colors.grey[50],
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Row(
            //             children: [
            //               Icon(
            //                 Icons.store_rounded,
            //                 color: Colors.grey[700],
            //               ),
            //               SizedBox(
            //                 width: 8,
            //               ),
            //               Text(
            //                 "Toko Saya",
            //                 style: TextStyle(
            //                   fontSize: 14,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     } else {
            //       return const SizedBox();
            //     }
            //   },
            // )
          ]),
    ));
  }

  BlocBuilder<UserBloc, UserState> btnTokoSaya() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded && state.isSeller) {
          return InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const MyStore()));
            },
            child: Container(
              // width: double.infinity,
              padding:
                  EdgeInsets.only(left: 14, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "My Store",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                  )
                ],
              ),
            ),
          );
        } else if (state is UserInitial) {
          return Container(
            // width: double.infinity,
            padding: EdgeInsets.only(left: 14, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "My Store",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                )
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
