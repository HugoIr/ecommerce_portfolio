import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBar(),
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 56,
            // color: Colors.grey[200],
            // padding: EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(
                  flex: 1,
                ),
                _navigationBarItem(
                    title: "Beranda", iconData: Icons.home_rounded),
                Spacer(
                  flex: 5,
                ),
                _navigationBarItem(
                    title: "Profil", iconData: Icons.person_rounded),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
          floatingActionButton: _floatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: SingleChildScrollView(
              child: Container(
            width: double.infinity,
            child: Column(
              children: [
                _space(),
                _carousel(),
                _space(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _subHeader("For you", () {}),
                ),
                _space26(),
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
                      return _cardItem();
                    },
                  ),
                ),
                _space(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _subHeader("Kategori", () {}),
                ),
                _space26(),
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
                      return _cardKategori("Komik", 'assets/icons/comic.png');
                    },
                  ),
                ),
                _space(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _subHeader("Kategori", () {}),
                ),
                _space26(),
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
                      return _cardStore();
                    },
                  ),
                ),
                _space26()
              ],
            ),
          )),
        ),
      ),
    );
  }

  Column _navigationBarItem(
      {required String title, required IconData iconData}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 32,
          color: Colors.grey[600],
        ),
        SizedBox(
          height: 2,
        ),
        Text(title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w200,
            ))
      ],
    );
  }

  Padding _floatingActionButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(shape: BoxShape.circle),
            padding: EdgeInsets.all(0),
            alignment: Alignment.center,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: Colors.amber[600],
                child: Container(
                  // padding: EdgeInsets.only(top: 4),
                  // color: Colors.blue,
                  alignment: Alignment.center,
                  child: officialStoreIcon(
                      size: 14,
                      padding: 4,
                      iconColor: Colors.amber[600],
                      bgColor: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Official",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget _cardStore() {
    return Container(
      width: 130,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[100]),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          "Bukularis",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: 4,
        ),
        Text("Depok",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[800],
            )),
      ]),
    );
  }

  Widget _cardKategori(String name, String asset) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              asset,
              width: 50,
              height: 50,
              color: Colors.blueAccent[700],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }

  SizedBox _space26() {
    return SizedBox(
      height: 26,
    );
  }

  Row _subHeader(String text, Function() onTap) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 0.28),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(width: 0.15)),
            padding: EdgeInsets.all(4),
            child: Icon(
              Icons.arrow_right_alt_rounded,
              size: 16,
              color: Colors.grey[600],
            ),
          ),
        )
      ],
    );
  }

  Widget _cardItem() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //       offset: Offset(0, 2),
          //       spreadRadius: 1,
          //       blurStyle: BlurStyle.normal,
          //       blurRadius: 2,
          //       color: Color.fromARGB(255, 240, 239, 239))
          // ],
        ),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network('https://picsum.photos/130')),
            Container(
              // width: 70,
              constraints: BoxConstraints(maxWidth: 80),
              // height: 20,
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.amber[300]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                officialStoreIcon(),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Official",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
            Padding(
                // top: 140,
                padding: EdgeInsets.only(top: 142, left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 90,
                          // padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "12 Teknologi Lele Tingkatkan",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.grey[600],
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Rp72.000",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rp72.000",
                          style: TextStyle(
                              fontSize: 11,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "20% Off",
                          style: TextStyle(
                              fontSize: 11, color: Colors.greenAccent),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Container officialStoreIcon({
    double? size,
    double? padding,
    Color? iconColor,
    Color? bgColor,
  }) {
    return Container(
      child: Icon(
        Icons.star,
        color: iconColor ?? Colors.yellow[600],
        size: size ?? 10,
      ),
      padding: EdgeInsets.all(padding ?? 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor ?? Colors.purple[400]),
    );
  }

  SizedBox _space() => const SizedBox(
        height: 20,
      );

  CarouselSlider _carousel() {
    return CarouselSlider(
      options: CarouselOptions(height: 170.0),
      items: [
        1,
        2,
        3,
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      'https://picsum.photos/${MediaQuery.of(context).size.width.round()}/220'),
                ));
          },
        );
      }).toList(),
    );
  }

  Column _testScrollable() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.amber),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 100,
          height: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.amber),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 100,
          height: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.amber),
        ),
      ],
    );
  }

  Column _circularMenu({
    required String menuName,
    required String asset,
    bool isSelected = false,
    Color? color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.yellow[200]),
          width: 70,
          height: 70,
          child: Center(
              child: Image.asset(
            asset,
            width: 36,
            height: 36,
            color: color,
          )),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          menuName,
          style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              fontSize: 16,
              color: Colors.blueAccent[700]),
        )
      ],
    );
  }

  PreferredSize _appBar() => PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: Column(
          children: [
            Container(
              height: 80,
              color: Colors.blueAccent[700],
              child: _rowAppBar(),
            ),
            _menusAppBar(),
          ],
        ),
      );

  Container _menusAppBar() {
    return Container(
      height: 112,
      width: double.infinity,
      color: Colors.white,
      child: Stack(children: [
        Container(
            width: double.infinity,
            height: 42,
            decoration: BoxDecoration(
                color: Colors.blueAccent[700],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)))),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _circularMenu(
                menuName: "Books",
                asset: "assets/header/book_orange.png",
                isSelected: true),
            _circularMenu(
              menuName: "Toys",
              asset: "assets/header/construction.png",
            ),
            _circularMenu(
                menuName: "Games",
                asset: "assets/header/game_controller.png",
                color: Colors.orange[900]),
          ],
        )
      ]),
    );
  }

  Row _rowAppBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 235,
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Icon(
            Icons.search_rounded,
            size: 22,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.email_outlined, color: Colors.white),
        SizedBox(
          width: 12,
        ),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
        SizedBox(
          width: 12,
        ),
        Icon(Icons.shopping_cart_outlined, color: Colors.white),
        SizedBox(
          width: 14,
        ),
      ],
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
