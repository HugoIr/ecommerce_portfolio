import 'package:flutter/material.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/card_item.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/pages/search_page/filter_sheet.dart';

List<Map<String, dynamic>> listFilterMenu = [
  {
    'name': "Filter",
    'icon': Image.asset(
      "assets/icons/filter.png",
      width: 22,
      height: 22,
      color: Colors.grey[700],
    ),
    "onTap": (context) {
      showModalBottomSheet(
          // isScrollControlled: true,
          context: context,
          builder: (builder) {
            return FilterSheet();
          });
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (builder) => FilterSheet()));
    }
  },
  {
    'name': "Official Store",
    'icon': officialStoreIcon(size: 12),
  },
  {
    'name': "Diskon",
  },
];

// Widget gridItems(List<Item> list) {
//   return Container(
//     height: 1000,
//     padding: EdgeInsets.symmetric(horizontal: 20),
//     width: double.infinity,
//     child: GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             mainAxisExtent: 270,
//             crossAxisCount: 2,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20),
//         itemCount: list.length,
//         itemBuilder: (buildContext, index) {
//           return CardItem(
//             index: index,
//             width: 170,
//             xPadding: 14,
//             id: list[index].id ?? 0 ,
//             name: list[index].name,
//             url: list[index].url,
//             price: list[index].price,
//             discount: list[index].discount,
//             idSeller: list[index].idSeller,
//             sellerName: list[index].sellerName,
//             stock: list[index].stock ?? 0,
//           );
//         }),
//   );
// }
