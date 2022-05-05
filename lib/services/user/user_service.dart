import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funesia_clone/data/model/remote/item.dart';

class UserService {
  FirebaseFirestore firebaseFirestore;

  UserService({required this.firebaseFirestore});

  Future<dynamic> getListsId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("masuk sini dl ${user.uid}");
      final listkey = await getCurrentWishlist();
      print("lsitkey ${listkey.keys}");
      return listkey.keys;
    }
    print("user null");
  }

  void addNewUser(String uid, String email) {
    firebaseFirestore
        .collection("users")
        .doc(uid)
        .set({
          "uid": uid,
          "email": email,
          "wishlist": {},
        })
        .then((_) => print("success add"))
        .catchError((e) => print("error $e"));
  }

  // Future<Map<String, dynamic>> getAllWishlist(String uid) async {
  //   await firebaseFirestore.collection("users").get().then(
  //     (QuerySnapshot querySnapshot) {
  //       print("querysnapshot data ${querySnapshot.docs[0].data()}");
  //       return querySnapshot.docs[0].data();
  //     },
  //   );
  //   return {};
  // }

  dynamic getCurrentWishlist() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var wishlist;
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .get()
          .then((value) {
        wishlist = value.data()!["wishlist"];
        // print("wishlist $wishlist");
      });
      return wishlist;
    } else {
      print("error");
    }
  }

  Future<List<Item>> getListOfCurrentWishlist() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var wishlist;
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .get()
          .then((value) {
        wishlist = _convertMapToItem(value.data()!["wishlist"]);
      });

      return wishlist;
    } else {
      print("error");
      return [];
    }
  }

  List<Item> _convertMapToItem(Map<String, dynamic> map) {
    List<Item> list = [];
    map.forEach((key, value) {
      print("$key $value");
      list.add(Item(
          id: int.parse(key),
          name: value['name'],
          price: value['price'],
          discount: value['discount'],
          url: value["url"]));
    });
    return list;
  }

  dynamic addWishlist(
      {required int id,
      required String name,
      required String url,
      required double price,
      required double discount}) async {
    CollectionReference users = firebaseFirestore.collection("users");
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // print("currentwishlist $currentWishlist");
        final updatedWishlist = await _addItemToExistingWishlist(
            id: id, name: name, url: url, price: price, discount: discount);

        print("AddWishList service: wishlist after updated $updatedWishlist");
        if (updatedWishlist != null) {
          await users.doc(user.uid).update({"wishlist": updatedWishlist});
        }
      } else {
        print("login dlu dong");
      }

      print("updatedd");
    } on FirebaseException catch (e) {
      print("e $e");
    } catch (e) {
      print("e $e");
    }
  }

  dynamic removeWishlist({
    required int id,
  }) async {
    CollectionReference users = firebaseFirestore.collection("users");
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final updatedWishlist = await _removeItemFromExistingWishlist(id: id);

        print(
            "RemoveWishList service: wishlist after updated $updatedWishlist");
        if (updatedWishlist != null) {
          await users.doc(user.uid).update({"wishlist": updatedWishlist});
        }
      } else {
        print("login dlu dong");
      }

      print("removed");
    } on FirebaseException catch (e) {
      print("e $e");
    } catch (e) {
      print("e $e");
    }
  }

  dynamic _addItemToExistingWishlist(
      {required int id,
      required String name,
      required String url,
      required double price,
      required double discount}) async {
    var currentWishlist = await getCurrentWishlist();

    if (currentWishlist.isEmpty || currentWishlist[id] == null) {
      currentWishlist[id.toString()] = {
        "name": name,
        "url": url,
        "price": price,
        "discount": discount
      };
      return currentWishlist;
    } else {
      print('elsa');
      return null;
    }
  }

  dynamic _removeItemFromExistingWishlist({
    required int id,
  }) async {
    print("id yg ingin diremove: $id");
    var currentWishlist = await getCurrentWishlist();

    if (currentWishlist.isNotEmpty || currentWishlist[id] != null) {
      currentWishlist.remove(id.toString());

      return currentWishlist;
    } else {
      print('elsa');
      return null;
    }
  }
}
