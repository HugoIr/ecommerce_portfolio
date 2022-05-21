import 'package:flutter/material.dart';
import 'package:funesia_clone/common/constant.dart';
import 'package:funesia_clone/common/utils/commonUrl.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/app_bar/raw_app_bar.dart';

class ProductItem extends StatelessWidget {
  final String text;
  final String price;
  const ProductItem({Key? key, required this.text, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                color: Colors.black12,
                width: 70,
                height: 70,
                child: Image.network(
                  dummyPic + "200",
                  cacheHeight: 70,
                  cacheWidth: 70,
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text + "dasdasdsadsdwkewkewkekwekwkekwekwkewk sdwdwdwdw",
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Rp$price",
                ),
              ],
            )),
          ]),
          SizedBox(
            height: 8,
          ),
          Divider(
            thickness: 0.5,
          ),
          Row(
            children: [
              subInfo(
                  asset: "assets/seller/layers.png", name: "Stock", total: 20),
              Spacer(
                flex: 1,
              ),
              subInfo(
                  asset: "assets/seller/sold_out.png",
                  name: "Sold",
                  total: 100),
              Spacer(
                flex: 1,
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Flexible(
                flex: 10,
                child: Container(
                  alignment: Alignment.center,
                  // width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey[400]!)),
                  child: Text(
                    "Archieve",
                    style: normalTextStyle.copyWith(fontSize: 12),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 10,
                child: Container(
                  alignment: Alignment.center,
                  // width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey[400]!)),
                  child: Text(
                    "Edit",
                    style: normalTextStyle.copyWith(fontSize: 12),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  // width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey[400]!)),
                  // child: Text(
                  //   "Delete",
                  //   style: normalTextStyle.copyWith(fontSize: 12),
                  // ),
                  child: Image.asset(
                    "assets/icons/bin.png",
                    width: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Row subInfo({
    required String asset,
    required String name,
    required int total,
  }) {
    return Row(
      children: [
        Image.asset(
          asset,
          width: 14,
          color: Colors.grey[700],
        ),
        SizedBox(width: 6),
        Text(
          "$name: ${total.toString()}",
          style: subTextStyle.copyWith(color: Colors.grey[600]),
        )
      ],
    );
  }
}
