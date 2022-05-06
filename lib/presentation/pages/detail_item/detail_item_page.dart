import 'package:flutter/material.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/custom_sliver_bar.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/search_page/search_app_bar.dart';

class DetailItemPage extends StatelessWidget {
  final int index;
  final int id;
  final String name;
  final String url;
  final double price;
  bool isSelected = false;
  final double? discount;
  DetailItemPage({
    Key? key,
    required this.index,
    required this.id,
    required this.name,
    required this.url,
    required this.price,
    this.isSelected = false,
    this.discount,
  }) : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: SearchAppBar(controller: controller),
        bottomNavigationBar: Container(
          height: 75,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 1,
                    blurStyle: BlurStyle.outer,
                    color: Colors.black12)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color.fromARGB(255, 89, 204, 93), width: 2)),
                  child: Icon(
                    Icons.chat_outlined,
                    size: 20,
                    color: Color.fromARGB(255, 89, 204, 93),
                  )),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black38, width: 0.5)),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      "-",
                      style: TextStyle(fontSize: 24, color: Colors.grey[600]),
                    ),
                    spaceHorizontal(),
                    Text("1"),
                    spaceHorizontal(),
                    Text(
                      "+",
                      style: TextStyle(fontSize: 24, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blueAccent[700]),
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                  child: Text(
                    "Beli",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 900,
            child: Stack(
              children: [
                _itemImage(width),
                Positioned(
                  top: 350,
                  child: Container(
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _priceAndIcons(),
                        space(),
                        Text(
                          "Judul Buku",
                          style: TextStyle(fontSize: 16),
                        ),
                        space(),
                        Text.rich(
                          TextSpan(
                              text: "Dijual oleh",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 12),
                              children: [
                                WidgetSpan(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: officialStoreIcon(),
                                )),
                                TextSpan(
                                  text: "Nama toko",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ]),
                        ),
                        space26(),
                        _rowCounter(width),
                        space(),
                        Text(
                          "Pariatur ut pariatur nulla Lorem dolore dolore ad ipsum quis adipisicing in do pariatur. Voluptate officia dolore officia nulla sunt anim dolor dolore occaecat velit sit esse aliqua. Reprehenderit magna sit duis laborum duis amet exercitation mollit eu. Velit esse aliqua ullamco amet. Est non laboris tempor non labore ea. Pariatur ut est ea voluptate minim excepteur ad laboris aute duis.",
                          style: TextStyle(
                              fontSize: 12, height: 1.5, letterSpacing: 0.08),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          "Ulasan Pembeli",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        space26(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              size: 18,
                              color: Colors.grey[350],
                            ),
                            Icon(
                              Icons.star_rate_rounded,
                              size: 18,
                              color: Colors.grey[350],
                            ),
                            Icon(
                              Icons.star_rate_rounded,
                              size: 18,
                              color: Colors.grey[350],
                            ),
                            Icon(
                              Icons.star_rate_rounded,
                              size: 18,
                              color: Colors.grey[350],
                            ),
                            Icon(
                              Icons.star_rate_rounded,
                              size: 18,
                              color: Colors.grey[350],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "0 (0)",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 46,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
    // body: CustomSliverBar(
    //   expandedHeight: 370,
    //   header: Stack(
    //     children: [
    //       Positioned(
    //           top: 80,
    //           child: Image.network(
    //             url,
    //             // scale: 2,
    //             // width: 500,
    //             // height: 500,
    //           ))
    //     ],
    //   ),
    //   child: Container(
    //     width: 300,
    //     height: 800,
    //   ),
    // ));
  }

  Stack _itemImage(double width) {
    return Stack(
      children: [
        Image.network(
          url,
          scale: 0.5,
        ),
        Positioned(
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.01),
                  Colors.black.withOpacity(0.7)
                ])),
            width: width,
            height: 160,
          ),
        )
      ],
    );
  }

  Container _rowCounter(double width) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300]!.withOpacity(0.8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _itemRowCounter(text: "Rating", number: 0),
          spaceHorizontal(),
          _verticalDivider(),
          spaceHorizontal(),
          _itemRowCounter(text: "Terjual", number: 0),
          spaceHorizontal(),
          _verticalDivider(),
          spaceHorizontal(),
          _itemRowCounter(text: "Ulasan", number: 0),
        ],
      ),
    );
  }

  SizedBox spaceHorizontal() {
    return const SizedBox(
      width: 36,
    );
  }

  Container _verticalDivider() {
    return Container(
      color: Colors.grey[400],
      width: 1,
      height: 30,
    );
  }

  Column _itemRowCounter({required String text, required int number}) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(number.toString())
      ],
    );
  }

  Row _priceAndIcons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Rp72.000",
          style: TextStyle(
              color: Colors.teal[300], fontSize: 24, letterSpacing: 0.08),
        ),
        Spacer(
          flex: 10,
        ),
        Icon(
          Icons.share,
          size: 28,
          color: Colors.grey[600],
        ),
        Spacer(
          flex: 1,
        ),
        Icon(
          Icons.favorite,
          size: 28,
          color: Colors.red,
        ),
      ],
    );
  }
}
