import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/cart/cart_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/search_page/search_result_bloc.dart';
import 'package:funesia_clone/presentation/pages/checkout/checkout.dart';
import 'package:funesia_clone/services/user/user_service.dart';

class SearchAppBar extends StatelessWidget with PreferredSizeWidget {
  const SearchAppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 14,
      elevation: 0.5,
      backgroundColor: Colors.white,
      title: Container(
          child: Row(
        children: [
          Image.asset(
            "assets/icons/search.png",
            width: 22,
            color: Colors.grey[600],
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 180,
            height: 40,
            alignment: Alignment.center,
            child: TextField(
              onSubmitted: (value) {
                print("helo $value");
                // BlocProvider.of<SearchResultBloc>(context)
                //   ..add(SearchEvent(keyword: value));
                context.read<SearchResultBloc>()
                  ..add(SearchEvent(keyword: value));
              },
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              textInputAction: TextInputAction.go,
              cursorColor: Colors.grey[500],
              cursorHeight: 20,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.all(8)),
              controller: controller,
            ),
          )
        ],
      )),
      leading: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: Colors.grey[600],
        ),
      ),
      actions: [
        Icon(
          Icons.favorite_border_rounded,
          color: Colors.grey[600],
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
          child: Icon(
            Icons.shopping_cart_rounded,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(58);
}
