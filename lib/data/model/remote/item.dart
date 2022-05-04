import 'package:funesia_clone/common/utils/commonUrl.dart';

class Item {
  int id;
  String name;
  String url;
  double price;
  double? discount;
  bool isSelected;
  Item({
    required this.id,
    required this.name,
    required this.url,
    required this.price,
    this.discount,
    this.isSelected = false,
  });
}

List<Item> dummyItemsList = [
  Item(
      id: 1,
      name: "12 Teknologi Lele Tingkatkan Laba",
      price: 72000,
      url: "${dummyPic}170",
      discount: 20),
  Item(
      id: 2,
      name: "Lele Tingkatkan Laba",
      price: 72000,
      url: "${dummyPic}170",
      discount: 20),
  Item(
      id: 3,
      name: "Teknologi Laba",
      price: 72000,
      url: "${dummyPic}170",
      discount: 20),
  Item(
      id: 4,
      name: "Lele Labadi",
      price: 72000,
      url: "${dummyPic}170",
      discount: 20),
  Item(
      id: 5,
      name: "Cat Lovers",
      price: 72000,
      url: "${dummyPic}170",
      discount: 20),
  Item(
      id: 6,
      name: "Atomic Habits",
      price: 72000,
      url: "${dummyPic}170",
      discount: 20),
  Item(
      id: 7, name: "Atomic", price: 72000, url: "${dummyPic}170", discount: 20),
  Item(
      id: 8,
      name: "5 AM Club",
      price: 72000,
      url: "${dummyPic}170",
      discount: 20),
];
