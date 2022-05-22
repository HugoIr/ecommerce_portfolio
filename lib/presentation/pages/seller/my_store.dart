import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funesia_clone/common/constant.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/app_bar/raw_app_bar.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/profile/reusable_widget_profile.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/pages/auth/sign_out/sign_out.dart';
import 'package:funesia_clone/presentation/pages/seller/product/my_product.dart';
import 'package:path/path.dart';

class MyStore extends StatelessWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: RawAppBar(
        title: Text(
          "My Store",
          style: appBarStyle,
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              space(),
              rowIdentity(context),
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
                        "Pesanan Saya",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            opsiPesananSaya(
                              asset: "assets/profile/wallet.png",
                              text: "Belum Bayar",
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            opsiPesananSaya(
                              asset: "assets/profile/shopping_bag.png",
                              text: "Dikemas",
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            opsiPesananSaya(
                              asset: "assets/profile/van_cargo.png",
                              text: "Dikirim",
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            opsiPesananSaya(
                              asset: "assets/profile/invoice.png",
                              text: "Selesai",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => MyProduct()));
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.store_rounded,
                        color: Colors.grey[700],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "My Product",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      )),
    );
  }

  Widget rowIdentity(context) {
    return Container(
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
                "hugsToko",
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                FirebaseAuth.instance.currentUser?.email ??
                    "Pengikut 0  |  Mengikuti 0",
                style: TextStyle(fontSize: 12),
              ),
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
}
