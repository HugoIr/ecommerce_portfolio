import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/presentation/components/blocs/search_page/search_result_bloc.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/search_page/reusable_widgets_search_page.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/search_page/searchResult.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  SearchPage({
    Key? key,
    String? controllerText,
  }) {
    controller.text = controllerText ?? "";
  }

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
                  // BlocProvider.of<SearchResultBloc>(context)
                  //   ..add(SearchEvent(keyword: "keyword"));
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
        color: Colors.white,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            space(),
            filterMenus(),
            space(),
            BlocBuilder<SearchResultBloc, SearchResultState>(
              builder: (context, state) {
                if (state is SearchResultLoaded) {
                  if (state.results.isEmpty) {
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
                    return SearchResult(list: state.results);
                  }
                } else if (state is SearchResultLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey[500],
                    ),
                  );
                } else {
                  print("masuk else search");
                  return SearchResult(list: dummyItemsList);
                }
              },
            )
          ]),
        ),
      ),
    );
  }

  Widget filterMenus() {
    return Container(
      height: 32,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listFilterMenu.length,
          separatorBuilder: (builder, index) {
            return const SizedBox(
              width: 12,
            );
          },
          itemBuilder: (context, index) {
            return _filterMenuItem(
                context: context,
                name: listFilterMenu[index]['name'],
                icon: listFilterMenu[index]['icon'],
                navigatorFunction: listFilterMenu[index]['onTap']);
          }),
    );
  }

  Widget _filterMenuItem({
    context,
    required String name,
    Widget? icon,
    Function(dynamic)? navigatorFunction,
  }) {
    return InkWell(
      onTap: () {
        navigatorFunction!(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          // color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 202, 202, 202)),
        ),
        child: Row(children: [
          icon ?? const SizedBox(),
          SizedBox(
            width: icon != null ? 8 : 0,
          ),
          Text(
            name,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ]),
      ),
    );
  }
}
