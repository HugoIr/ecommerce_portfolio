import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  final productCollection = FirebaseFirestore.instance.collection("product");
  final user = FirebaseAuth.instance.currentUser;
  final uuid = Uuid();
  dynamic getListProduct() async {
    List<Item> list = [];
    QuerySnapshot querySnapshot = await productCollection.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    // allData.map((data) {
    //   print("data $data");
    // });

    for (dynamic data in allData) {
      if (data != null) {
        List rawList = data["product"];
        // print("rawLIST $rawList");
        for (dynamic rawItem in rawList) {
          Item item = Item(
              id: uuid.v4(),
              idSeller: rawItem["idSeller"],
              sellerName: rawItem["sellerName"],
              name: rawItem["name"],
              price: rawItem["price"],
              url: rawItem["url"],
              discount: rawItem["discount"],
              stock: rawItem["stock"]);
          list.add(item);
        }
      }
    }

    print("kluar getListProduct $list");
    return list;
  }

  dynamic getExistingProduct(String idSeller) async {
    var existingProduct;
    await productCollection.doc(idSeller).get().then((value) {
      print("valuedata ${value.data()}");
      existingProduct = value.data()!["product"];
    });
    print("existingProduct $existingProduct");
    return existingProduct;
  }

  dynamic createProduct(Item item) async {
    var existingProduct = await getExistingProduct(user!.uid);
    if (existingProduct == null) {
      print("product not exist");
      existingProduct = [item.toJson()];
    } else {
      existingProduct.add(item.toJson());
      print("product exist");
    }
    await productCollection.doc(user!.uid).set({
      "product": existingProduct,
    });

    // if (doc.data()!["chatConnection"] == null) {
    //     Map<String, dynamic> newChatConnection = {
    //       idTo: {"channelId": channelId},
    //     };
    //     userCollection.doc(idFrom).set(newChatConnection);
    //     print("if no chatconn new conn $newChatConnection");

    //     return newChatConnection;
    //   } else {
    //     print("else append");
    //     // append
    //     final updatedMap = doc.data();
    //     updatedMap!["chatConnection"][idTo] = {"channelId": channelId};
    //     print("Updatedd map $updatedMap");
    //     userCollection.doc(idFrom).update(updatedMap);
    //     return updatedMap;
    //   }
  }
}
