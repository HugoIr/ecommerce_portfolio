import 'package:funesia_clone/common/utils/commonUrl.dart';

class Item {
  String id;
  String name;
  String url;
  dynamic price;
  dynamic? discount;
  String idSeller;
  String sellerName;
  int? stock;
  int sold;
  bool isSelected;

  Item({
    required this.id,
    required this.name,
    required this.url,
    required this.price,
    this.discount,
    this.isSelected = false,
    required this.idSeller,
    this.stock,
    required this.sellerName,
    this.sold = 0,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "url": url,
      "price": price,
      "idSeller": idSeller,
      "sellerName": sellerName,
      "sold": sold,
    };
    if (stock != null) {
      map["stock"] = stock;
    }
    if (discount != null) {
      map["discount"] = discount;
    }
    return map;
  }
}

class CartItem extends Item {
  int total;
  CartItem({
    required String id,
    required String name,
    required String url,
    required double price,
    required this.total,
    required String idSeller,
    required String sellerName,
    required int stock,
  }) : super(
          id: id,
          name: name,
          url: url,
          price: price,
          idSeller: idSeller,
          sellerName: sellerName,
          stock: stock,
        );
}

List<Item> dummyItemsList = [
  Item(
    id: "1",
    name: "12 Teknologi Lele Tingkatkan Laba",
    price: 72000,
    url: "${dummyPic}450",
    discount: 20,
    idSeller: '42LrHFFQ4MW2cf4BROJzMLLeGpN2',
    sellerName: "Hugs Toko",
    stock: 10,
  ),
  Item(
    id: "2",
    name: "Lele Tingkatkan Laba",
    price: 72000,
    url: "${dummyPic}450",
    discount: 20,
    idSeller: '42LrHFFQ4MW2cf4BROJzMLLeGpN2',
    sellerName: "Hugs Toko",
    stock: 10,
  ),
  Item(
    id: "3",
    name: "Teknologi Laba",
    price: 72000,
    url: "${dummyPic}450",
    discount: 20,
    idSeller: '42LrHFFQ4MW2cf4BROJzMLLeGpN2',
    sellerName: "Hugs Toko",
    stock: 10,
  ),
  Item(
    id: "4",
    name: "Lele Labadi",
    price: 72000,
    url: "${dummyPic}450",
    discount: 20,
    idSeller: '42LrHFFQ4MW2cf4BROJzMLLeGpN2',
    sellerName: "Hugs Toko",
    stock: 10,
  ),
  Item(
    id: "5",
    name: "Cat Lovers",
    price: 72000,
    url: "${dummyPic}450",
    discount: 20,
    idSeller: '42LrHFFQ4MW2cf4BROJzMLLeGpN2',
    sellerName: "Hugs Toko",
    stock: 10,
  ),
  Item(
    id: "6",
    name: "Atomic Habits",
    price: 72000,
    url: "${dummyPic}450",
    discount: 20,
    idSeller: '42LrHFFQ4MW2cf4BROJzMLLeGpN2',
    sellerName: "Hugs Toko",
    stock: 10,
  ),
  Item(
    id: "7",
    name: "Atomic",
    price: 72000,
    url: "${dummyPic}450",
    discount: 20,
    idSeller: '42LrHFFQ4MW2cf4BROJzMLLeGpN2',
    sellerName: "Hugs Toko",
    stock: 10,
  ),
  Item(
    id: "8",
    name: "5 AM Club",
    price: 72000,
    url: "${dummyPic}450",
    discount: 20,
    idSeller: '42LrHFFQ4MW2cf4BROJzMLLeGpN2',
    sellerName: "Hugs Toko",
    stock: 10,
  ),
];
