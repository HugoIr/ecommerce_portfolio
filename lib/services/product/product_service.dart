import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class ProductService {
  final productCollection = FirebaseFirestore.instance.collection("product");
  final user = FirebaseAuth.instance.currentUser;
  final uuid = const Uuid();
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

      if (value.data() != null) {
        if (value.data()!["product"] != null) {
          existingProduct = value.data()!["product"];
        }
      }
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
  }

  Future uploadImageToFirebase(XFile imageFile, String idProduct) async {
    // final filename = basename(path);
    UploadTask uploadTask;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('product-image/${user!.uid}/$idProduct');

    print("REF$ref");
    uploadTask = ref.putFile(File(imageFile.path));
    print("uploadTask${uploadTask.storage}");
    return Future.value(uploadTask);
  }
}
