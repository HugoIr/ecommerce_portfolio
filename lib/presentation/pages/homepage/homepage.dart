import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/search_page/search_result_bloc.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/card_item.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/pages/search_page/search_page.dart';
import 'package:funesia_clone/services/user/user_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            space(),
            carousel(),
            space(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: subHeader(
                  text: "For you",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => BlocProvider(
                                  create: (context) => SearchResultBloc(
                                      userService: UserService(
                                          firebaseFirestore:
                                              FirebaseFirestore.instance)),
                                  child: SearchPage(),
                                )));
                  }),
            ),
            space26(),
            BlocBuilder<ForYouBloc, ForYouState>(
              builder: (context, state) {
                print("for you ui state $state");
                if (state is LoadedForYouState) {
                  return Container(
                    height: 240,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.listsItem.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (buildContext, index) {
                        return const SizedBox(
                          width: 14,
                        );
                      },
                      itemBuilder: (buildContext, index) {
                        return CardItem(
                          index: index,
                          id: state.listsItem[index].id,
                          name: state.listsItem[index].name,
                          url: state.listsItem[index].url,
                          price: state.listsItem[index].price,
                          discount: state.listsItem[index].discount,
                          idSeller: state.listsItem[index].idSeller,
                          sellerName: state.listsItem[index].sellerName,
                          isSelected: state.listsItem[index].isSelected,
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            space(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: subHeader(text: "Kategori", onTap: () {}),
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
              child: subHeader(
                  text: "Official Store",
                  onTap: () {},
                  icon: officialStoreIcon(size: 14)),
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
