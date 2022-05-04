import 'package:flutter/material.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/pages/auth/sign_out/sign_out.dart';
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
            Text(
              "My Profile",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            space(),
            rowIdentity(context),
            space(),
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
                      "Pesanan Saya",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          opsiPesananSaya(
                            asset: "assets/profile/wallet.png",
                            text: "Belum Bayar",
                          ),
                          spaceHorizontal(),
                          opsiPesananSaya(
                            asset: "assets/profile/shopping_bag.png",
                            text: "Dikemas",
                          ),
                          spaceHorizontal(),
                          opsiPesananSaya(
                            asset: "assets/profile/van_cargo.png",
                            text: "Dikirim",
                          ),
                          spaceHorizontal(),
                          opsiPesananSaya(
                            asset: "assets/profile/invoice.png",
                            text: "Selesai",
                          ),
                          spaceHorizontal(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
    ));
  }

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
          width: 30,
          height: 30,
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          width: 40,
          child: Text(
            text,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  InkWell btnBukaStore() {
    return InkWell(
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
                child: rightArrow(color: Colors.white, widthBorder: 0.75))
          ],
        ),
      ),
    );
  }

  SizedBox rowIdentity(context) {
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
          Spacer(
            flex: 1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Budi Setiawan",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "budisetiawan@gmail.com",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "0851323128429",
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
