import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';

class CardItem extends StatelessWidget {
  final int id;
  final String name;
  final String url;
  final double price;
  bool isSelected = false;
  final double? discount;
  double width = 130;
  final double? height;
  final double? xPadding;

  CardItem(
      {Key? key,
      required this.id,
      required this.name,
      required this.url,
      required this.price,
      this.isSelected = false,
      this.discount,
      this.width = 130,
      this.height,
      this.xPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(url),
            ),
            Container(
              // width: 70,
              constraints: BoxConstraints(maxWidth: 80),
              // height: 20,
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.amber[300]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                officialStoreIcon(),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Official",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
            Padding(
                // top: 140,
                padding: EdgeInsets.only(
                    top: width + 12, left: xPadding ?? 8, right: xPadding ?? 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            // width: width * (8.5 / 13),
                            alignment: Alignment.centerLeft,
                            // padding: EdgeInsets.only(left: 8),
                            child: Text(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            print(
                                "ISSELECTEDDD dari carditem $id : $isSelected");
                            if (!isSelected) {
                              BlocProvider.of<ForYouBloc>(context)
                                ..add(AddToWishlistEvent(
                                    id: id,
                                    name: name,
                                    url: url,
                                    price: price,
                                    discount: discount!));
                            } else {
                              // BlocProvider.of<ForYouBloc>(context)
                              //   ..add(RemoveToWishlistEvent(id: id));
                              context
                                  .read<ForYouBloc>()
                                  .add(RemoveToWishlistEvent(id: id));
                            }
                          },
                          child: isSelected
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border_rounded,
                                  color: Colors.grey[600],
                                ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Rp72.000",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rp72.000",
                          style: TextStyle(
                              fontSize: 11,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "20% Off",
                          style: TextStyle(
                              fontSize: 11, color: Colors.greenAccent),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
