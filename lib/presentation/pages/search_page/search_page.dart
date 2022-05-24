import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/search_page/search_result_bloc.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/search_page/reusable_widgets_search_page.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/search_page/searchResult.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/search_page/search_app_bar.dart';

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
      appBar: SearchAppBar(controller: controller),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            space(),
            filterMenus(),
            space(),
            BlocBuilder<SearchResultBloc, SearchResultState>(
              // buildWhen: ((previous, current) {
              //   return true;
              // }),
              builder: (context, searchState) {
                print("SEARCHBLOC state $searchState");
                if (searchState is SearchResultLoaded) {
                  if (searchState.results.isEmpty) {
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
                    print("FILTEREDD");
                    return SearchResult(
                      list: searchState.results,
                      isForFilter: true,
                    );
                  }
                } else if (searchState is SearchResultLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey[500],
                    ),
                  );
                } else {
                  print("masuk else search");
                  context.read<ForYouBloc>()..add(GetForYouEvent());
                  return BlocBuilder<ForYouBloc, ForYouState>(
                    builder: (context, forYouState) {
                      if (forYouState is LoadedForYouState) {
                        // print("forYOu listitem ${forYouState.listsItem.map(
                        //   (e) => print(e.isSelected),
                        // )}");
                        return SearchResult(
                          list: forYouState.listsItem,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
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
