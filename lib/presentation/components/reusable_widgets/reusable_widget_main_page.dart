import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';

Padding floatingActionButton() {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(shape: BoxShape.circle),
          padding: EdgeInsets.all(0),
          alignment: Alignment.center,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.amber[600],
              child: Container(
                // padding: EdgeInsets.only(top: 4),
                // color: Colors.blue,
                alignment: Alignment.center,
                child: officialStoreIcon(
                    size: 14,
                    padding: 4,
                    iconColor: Colors.amber[600],
                    bgColor: Colors.white),
              ),
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "Official",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
        ),
      ],
    ),
  );
}

Widget cardStore() {
  return Container(
    width: 130,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.grey[100]),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      SizedBox(
        height: 12,
      ),
      Text(
        "Bukularis",
        style: TextStyle(fontSize: 14),
      ),
      SizedBox(
        height: 4,
      ),
      Text("Depok",
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[800],
          )),
    ]),
  );
}

Widget cardKategori(String name, String asset) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    elevation: 2,
    child: Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            asset,
            width: 50,
            height: 50,
            color: Colors.blueAccent[700],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey[800],
                fontWeight: FontWeight.w300),
          )
        ],
      ),
    ),
  );
}

SizedBox space26() {
  return SizedBox(
    height: 26,
  );
}

Row subHeader({
  required String text,
  required Function() onTap,
  Widget? icon,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.28),
            ),
            SizedBox(
              width: icon != null ? 8 : 0,
            ),
            icon ?? const SizedBox(),
          ],
        ),
      ),
      GestureDetector(
        onTap: onTap,
        child: rightArrow(),
      )
    ],
  );
}

Container rightArrow({Color? color, double? widthBorder}) {
  return Container(
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            width: widthBorder ?? 0.25, color: color ?? Colors.black)),
    padding: EdgeInsets.all(4),
    child: Icon(
      Icons.arrow_right_alt_rounded,
      size: 16,
      color: color ?? Colors.grey[600],
    ),
  );
}

Container officialStoreIcon({
  double? size,
  double? padding,
  Color? iconColor,
  Color? bgColor,
}) {
  return Container(
    child: Icon(
      Icons.star,
      color: iconColor ?? Colors.yellow[600],
      size: size ?? 10,
    ),
    padding: EdgeInsets.all(padding ?? 2),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor ?? Colors.purple[400]),
  );
}

SizedBox space() => const SizedBox(
      height: 20,
    );

CarouselSlider carousel() {
  return CarouselSlider(
    options: CarouselOptions(height: 170.0),
    items: [
      1,
      2,
      3,
    ].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://picsum.photos/${MediaQuery.of(context).size.width.round()}/220',
                  // fit: BoxFit.fill,
                  loadingBuilder: ((buildContext, widget, imageChunkEvent) {
                    if (imageChunkEvent != null) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.grey[500],
                      ));
                    } else {
                      return widget;
                    }
                  }),
                ),
              ));
        },
      );
    }).toList(),
  );
}

Column testScrollable() {
  return Column(
    children: [
      Container(
        width: 100,
        height: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.amber),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        width: 100,
        height: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.amber),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        width: 100,
        height: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.amber),
      ),
    ],
  );
}
