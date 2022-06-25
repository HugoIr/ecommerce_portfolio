import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funesia_clone/presentation/components/blocs/cart/cart_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/search_page/search_result_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/wishlist/wishlist_bloc.dart';
import 'package:funesia_clone/presentation/components/cubits/item_counter/item_counter_cubit.dart';
import 'package:funesia_clone/presentation/pages/checkout/checkout.dart';
import 'package:funesia_clone/presentation/pages/search_page/search_page.dart';
import 'package:funesia_clone/presentation/wishlist/wishlist.dart';
import 'package:funesia_clone/services/user/user_service.dart';

class AppBarHome extends StatelessWidget with PreferredSizeWidget {
  AppBarHome({Key? key}) : super(key: key);
  final double size = 192.w;
  final TextEditingController homeSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(size),
      child: Container(
        child: Column(
          children: [
            Container(
              height: 76.w,
              color: Colors.blueAccent[700],
              child: rowAppBar(context),
            ),
            menusAppBar(),
          ],
        ),
      ),
    );
  }

  Container menusAppBar() {
    return Container(
      height: 112.w,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.r),
            bottomRight: Radius.circular(50.r)),
      ),
      child: Stack(children: [
        Container(
            width: double.infinity,
            height: 42.w,
            decoration: BoxDecoration(
                color: Colors.blueAccent[700],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.r),
                    bottomRight: Radius.circular(50.r)))),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            circularMenu(
                menuName: "Books",
                asset: "assets/header/book_orange.png",
                isSelected: true),
            circularMenu(
              menuName: "Toys",
              asset: "assets/header/construction.png",
            ),
            circularMenu(
                menuName: "Games",
                asset: "assets/header/game_controller.png",
                color: Colors.orange[900]),
          ],
        )
      ]),
    );
  }

  Column circularMenu({
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
          width: 70.w,
          height: 70.w,
          child: Center(
              child: Image.asset(
            asset,
            width: 36.w,
            height: 36.w,
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

  Row rowAppBar(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 235,
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/search.png",
                width: 20,
                color: Colors.grey[600],
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: 170,
                height: 40,
                alignment: Alignment.center,
                child: TextField(
                  controller: homeSearchController,
                  onSubmitted: (value) {
                    print("value $value");
                    if (value.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => BlocProvider(
                                    create: (context) => SearchResultBloc(
                                        userService: UserService(
                                            firebaseFirestore:
                                                FirebaseFirestore.instance),
                                        context: context)
                                      ..add(SearchEvent(keyword: value)),
                                    child: SearchPage(
                                      controllerText: value,
                                    ),
                                  )));
                      homeSearchController.clear();
                    }
                  },
                  style: TextStyle(
                      color: Colors.grey[600], fontSize: 14, height: 1.4),
                  textInputAction: TextInputAction.go,
                  cursorColor: Colors.grey[500],
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                      hintText: "Cari",
                      hintStyle: TextStyle(),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.email_outlined, color: Colors.white),
        SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => BlocProvider(
                          create: (create) => WishlistBloc(
                              userService: UserService(
                                  firebaseFirestore:
                                      FirebaseFirestore.instance))
                            ..add(GetWishlistEvent()),
                          child: Wishlist(),
                        )));
          },
          child: Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 12,
        ),
        GestureDetector(
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => BlocProvider(
                            create: (context) => CartBloc(
                                userService: UserService(
                                    firebaseFirestore:
                                        FirebaseFirestore.instance))
                              ..add(GetCartEvent()),
                            child: Checkout(),
                          )));
            }),
            child: Icon(Icons.shopping_cart_outlined, color: Colors.white)),
        SizedBox(
          width: 14,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize

  Size get preferredSize => Size.fromHeight(size);
}
