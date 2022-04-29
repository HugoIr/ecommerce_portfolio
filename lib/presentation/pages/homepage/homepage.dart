import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            space(),
            carousel(),
            space(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: subHeader("For you", () {}),
            ),
            space26(),
            // _cardItem()

            Container(
              height: 240,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 5,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (buildContext, index) {
                  return SizedBox(
                    width: 14,
                  );
                },
                itemBuilder: (buildContext, index) {
                  return cardItem();
                },
              ),
            ),
            space(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: subHeader("Kategori", () {}),
            ),
            space26(),
            Container(
              height: 120,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 4,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (buildContext, index) {
                  return SizedBox(
                    width: 14,
                  );
                },
                itemBuilder: (buildContext, index) {
                  return cardKategori("Komik", 'assets/icons/comic.png');
                },
              ),
            ),
            space(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: subHeader("Kategori", () {}),
            ),
            space26(),
            Container(
              height: 180,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 4,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (buildContext, index) {
                  return SizedBox(
                    width: 14,
                  );
                },
                itemBuilder: (buildContext, index) {
                  return cardStore();
                },
              ),
            ),
            space26()
          ],
        ),
      ),
    );
  }

  // AppBar _appBar() => AppBar(
  //       backgroundColor: Colors.blueAccent[700],
  //       elevation: 0,
  //       shadowColor: Colors.transparent,
  //       bottom: PreferredSize(
  //         preferredSize: const Size.fromHeight(150.0),
  //         child: Container(
  //           height: 150,
  //           width: double.infinity,
  //           color: Colors.white,
  //           child: Stack(children: [
  //             Container(
  //                 width: double.infinity,
  //                 height: 60,
  //                 decoration: BoxDecoration(
  //                     color: Colors.blueAccent[700],
  //                     borderRadius: BorderRadius.only(
  //                         bottomLeft: Radius.circular(50),
  //                         bottomRight: Radius.circular(50)))),
  //             Row(
  //               mainAxisSize: MainAxisSize.max,
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 _circularMenu("Books", isSelected: true),
  //                 _circularMenu("Toys"),
  //                 _circularMenu("Games"),
  //               ],
  //             )
  //           ]),
  //         ),
  //       ),
  //       title: Container(
  //           width: 240,
  //           height: 36,
  //           decoration: BoxDecoration(
  //               color: Colors.white, borderRadius: BorderRadius.circular(10))),
  //       actions: [
  //         Icon(Icons.email_outlined),
  //         SizedBox(
  //           width: 14,
  //         ),
  //         Icon(Icons.favorite_border),
  //         SizedBox(
  //           width: 14,
  //         ),
  //         Icon(Icons.shopping_cart_outlined),
  //         SizedBox(
  //           width: 14,
  //         ),
  //       ],
  //     );
}
