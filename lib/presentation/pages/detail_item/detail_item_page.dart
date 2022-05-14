import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';
import 'package:funesia_clone/presentation/components/cubits/item_counter/item_counter_cubit.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/custom_sliver_bar.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/search_page/search_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/services/user/user_service.dart';

class DetailItemPage extends StatelessWidget {
  final int index;
  final int id;
  final String name;
  final String url;
  final double price;
  final double? discount;
  DetailItemPage({
    Key? key,
    required this.index,
    required this.id,
    required this.name,
    required this.url,
    required this.price,
    this.discount,
  }) : super(key: key);
  TextEditingController searchController = TextEditingController();
  TextEditingController totalItemController = TextEditingController(text: "1");
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: SearchAppBar(controller: searchController),
        // bottomNavigationBar: bottomNavBar(context),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: 950,
                child: Stack(
                  children: [
                    _itemImage(width),
                    Positioned(
                      top: 350,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _priceAndIcons(context),
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
                                  fontSize: 12,
                                  height: 1.5,
                                  letterSpacing: 0.08),
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
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: bottomNavBar(context)),
          ],
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

  Container bottomNavBar(BuildContext context) {
    return Container(
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
          itemInput(context),
          Material(
            color: Colors.blueAccent[700],
            borderRadius: BorderRadius.circular(25),
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                UserService(firebaseFirestore: FirebaseFirestore.instance)
                    .addToCart(
                        id: id,
                        name: name,
                        url: url,
                        price: price,
                        discount: discount!,
                        total: int.tryParse(totalItemController.text) ?? 1);

                FocusManager.instance.primaryFocus!.unfocus();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 46, vertical: 12),
                  child: Text(
                    "Beli",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Container itemInput(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black38, width: 0.5)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                context.read<ItemCounterCubit>().decreaseCounter();
              },
              child: Container(
                padding: EdgeInsets.all(4),
                child: Image.asset(
                  "assets/icons/minus.png",
                  width: 14,
                ),
              ),
            ),
          ),
          spaceHorizontal(width: 20),
          BlocBuilder<ItemCounterCubit, int>(
            builder: (context, currentCounter) {
              totalItemController.text = currentCounter.toString();
              totalItemController.selection = TextSelection.fromPosition(
                  TextPosition(offset: currentCounter.toString().length));
              print("CURR COUNTE R $currentCounter");
              return Container(
                width: 40,
                child: TextField(
                  onChanged: (val) {
                    context.read<ItemCounterCubit>().changeCounter(val);
                  },
                  controller: totalItemController,
                  style: TextStyle(color: Colors.blueAccent[700]),
                  cursorColor: Colors.blueAccent[700],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  // controller: totalItemController,
                ),
              );
              // return Text(currentCounter.toString(),
              //     style: TextStyle(
              //         fontSize: 14, color: Colors.blueAccent[700]));
            },
          ),
          spaceHorizontal(width: 20),
          Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                context.read<ItemCounterCubit>().increaseCounter();
              },
              child: Container(
                padding: EdgeInsets.all(4),
                child: Image.asset(
                  "assets/icons/plus.png",
                  width: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
          left: 0.0,
          right: 0.0,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.01),
                  Colors.black.withOpacity(0.7)
                ])),
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

  SizedBox spaceHorizontal({double width = 36}) {
    return SizedBox(
      width: width,
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

  Row _priceAndIcons(BuildContext context) {
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
        BlocBuilder<ForYouBloc, ForYouState>(
          builder: (context, state) {
            if (state is LoadedForYouState) {
              bool isFavourite = state.listsItem
                  .firstWhere((item) => item.id == id)
                  .isSelected;
              print("IS FAV $isFavourite");
              return InkWell(
                onTap: () {
                  if (!isFavourite) {
                    context.read<ForYouBloc>()
                      ..add(AddToWishlistEvent(
                          id: id,
                          name: name,
                          url: url,
                          price: price,
                          discount: discount!));
                  } else {
                    context.read<ForYouBloc>()
                      ..add(RemoveToWishlistEvent(id: id));
                  }
                },
                child: isFavourite
                    ? Icon(
                        Icons.favorite,
                        size: 28,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border_rounded,
                        size: 28,
                        color: Colors.grey[600],
                      ),
              );
            } else {
              return Icon(
                Icons.favorite_border_rounded,
                color: Colors.grey[600],
              );
            }
          },
        ),
      ],
    );
  }
}
