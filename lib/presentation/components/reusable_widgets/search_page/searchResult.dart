import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/search_page/search_result_bloc.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/card_item.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';

class SearchResult extends StatelessWidget {
  final List<Item> list;
  bool isForFilter;
  bool isForWishlist;
  SearchResult(
      {Key? key,
      required this.list,
      this.isForFilter = false,
      this.isForWishlist = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("REBUILD GASIH SI SEARHRESULT");
    return Container(
      height: 1000,
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 270,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: list.length,
        itemBuilder: (buildContext, index) {
          return CardItem(
            index: index,
            width: 170,
            xPadding: 14,
            id: list[index].id,
            name: list[index].name,
            url: list[index].url,
            price: list[index].price,
            discount: list[index].discount,
            isSelected: list[index].isSelected,
            idSeller: list[index].idSeller,
            sellerName: list[index].sellerName,
            isForFilter: isForFilter,
            isForWishlist: isForWishlist,
            stock: list[index].stock ?? 0,
          );
        },
      ),
    );
  }
}
