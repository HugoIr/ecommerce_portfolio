import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/wishlist/wishlist_bloc.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/search_page/searchResult.dart';

class Wishlist extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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

                  // context.read<SearchResultBloc>()
                  //   ..add(SearchEvent(keyword: value));
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
          Icon(
            Icons.shopping_cart_rounded,
            color: Colors.grey[600],
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            space(),
            BlocBuilder<WishlistBloc, WishlistState>(
              builder: (context, state) {
                print("REBUILD THE WISHLIST");
                if (state is WishlistLoadedState) {
                  if (state.listsItem.isEmpty) {
                    return Center(
                      child: Text(
                        "Produk tidak ditemukan",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700]),
                      ),
                    );
                  } else {
                    return SearchResult(
                      list: state.listsItem,
                      isForWishlist: true,
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey[500],
                    ),
                  );
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
