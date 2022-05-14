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
          "cart": {},
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

  dynamic getCurrentCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var cart;
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .get()
          .then((value) {
        cart = value.data()!["cart"];
        print("getCurrentCart cart $cart");
        if (cart == null) {
          firebaseFirestore
              .collection("users")
              .doc(user.uid)
              .update({"cart": {}});
          cart = {};
        }
      });
      return cart;
    } else {
      print("error");
    }
  }

  Future<List<CartItem>> getListOfCurrentCart() async {
    final cart = await getCurrentCart();
    return _convertMapToCartItem(cart);
  }

  List<CartItem> _convertMapToCartItem(Map<String, dynamic> map) {
    List<CartItem> list = [];
    map.forEach((key, value) {
      print("$key $value");
      list.add(CartItem(
          id: int.parse(key),
          name: value["name"],
          url: value["url"],
          price: value["price"],
          total: value["total"]));
    });
    return list;
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
        var currentWishlist = await getCurrentWishlist();
        final updatedWishlist = await _addItemToExistingList(
            id: id,
            name: name,
            url: url,
            price: price,
            discount: discount,
            list: currentWishlist);

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
        var currentWishlist = await getCurrentWishlist();
        final updatedWishlist =
            await _removeItemFromExistingList(id: id, list: currentWishlist);

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

  dynamic addToCart({
    required int id,
    required String name,
    required String url,
    required double price,
    required double discount,
    required int total,
  }) async {
    CollectionReference users = firebaseFirestore.collection("users");
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var currentCart = await getCurrentCart();

        final updatedCart = await _addItemToExistingCart(
          id: id,
          name: name,
          url: url,
          price: price,
          discount: discount,
          list: currentCart,
          total: total,
        );

        print("updatedCart service: updatedCart after updated $updatedCart");
        if (updatedCart != null) {
          await users.doc(user.uid).update({"cart": updatedCart});
        }
      } else {
        print("login dlu dong");
      }

      print("updatedd");
    } on FirebaseException catch (e) {
      print("error FirebaseException addtocart $e");
    } catch (e) {
      print("error general addtocart $e");
    }
  }

  dynamic addCart({
    required int id,
  }) async {
    CollectionReference users = firebaseFirestore.collection("users");
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var currentCart = await getCurrentCart();

        currentCart[id.toString()]["total"] =
            currentCart[id.toString()]["total"] + 1;
        if (currentCart != null) {
          await users.doc(user.uid).update({"cart": currentCart});
        }
      } else {
        print("login dlu dong");
      }
    } on FirebaseException catch (e) {
      print("error FirebaseException addtocart $e");
    } catch (e) {
      print("error general addtocart $e");
    }
  }

  dynamic updateCartTotal({
    required int id,
    required int total,
  }) async {
    CollectionReference users = firebaseFirestore.collection("users");
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var currentCart = await getCurrentCart();

        if (currentCart != null) {
          if (total >= 1) {
            currentCart[id.toString()]["total"] = total;
          } else {
            currentCart[id.toString()]["total"] = 1;
          }

          await users.doc(user.uid).update({"cart": currentCart});
        }
      } else {
        print("login dlu dong");
      }
    } on FirebaseException catch (e) {
      print("error FirebaseException addtocart $e");
    } catch (e) {
      print("error general addtocart $e");
    }
  }

  dynamic removeCartItem({
    required int id,
  }) async {
    CollectionReference users = firebaseFirestore.collection("users");
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var currentCart = await getCurrentCart();

        if (currentCart != null) {
          currentCart.remove(id.toString());
          await users.doc(user.uid).update({"cart": currentCart});
        }
      } else {
        print("login dlu dong");
      }
    } on FirebaseException catch (e) {
      print("error FirebaseException addtocart $e");
    } catch (e) {
      print("error general addtocart $e");
    }
  }

  dynamic reduceCart({
    required int id,
  }) async {
    CollectionReference users = firebaseFirestore.collection("users");
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var currentCart = await getCurrentCart();

        int updatedTotal = currentCart[id.toString()]["total"] - 1;
        if (currentCart != null && updatedTotal >= 1) {
          currentCart[id.toString()]["total"] = updatedTotal;
          await users.doc(user.uid).update({"cart": currentCart});
        }
      } else {
        print("login dlu dong");
      }
    } on FirebaseException catch (e) {
      print("error FirebaseException addtocart $e");
    } catch (e) {
      print("error general addtocart $e");
    }
  }

  dynamic updateCart({
    required int id,
    required String name,
    required String url,
    required double price,
    required double discount,
    required int total,
  }) async {
    CollectionReference users = firebaseFirestore.collection("users");
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var currentCart = await getCurrentCart();
        final updatedCart = await _addItemToExistingCart(
          id: id,
          name: name,
          url: url,
          price: price,
          discount: discount,
          list: currentCart,
          total: total,
        );

        print("updatedCart service: updatedCart after updated $updatedCart");
        if (updatedCart != null) {
          await users.doc(user.uid).update({"cart": updatedCart});
        }
      } else {
        print("login dlu dong");
      }

      print("updatedd");
    } on FirebaseException catch (e) {
      print("error FirebaseException addtocart $e");
    } catch (e) {
      print("error general addtocart $e");
    }
  }

  dynamic removeFromCart({
    required int id,
    required int total,
  }) async {
    CollectionReference users = firebaseFirestore.collection("users");
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var currentCart = await getCurrentCart();
        final updatedCart = await _removeItemFromExistingCart(
            id: id, list: currentCart, total: total);

        print("RemoveCart service: updatedCart after updated $updatedCart");
        if (updatedCart != null) {
          await users.doc(user.uid).update({"cart": updatedCart});
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

  dynamic _addItemToExistingCart({
    required int id,
    required String name,
    required String url,
    required double price,
    required double discount,
    required Map list,
    required int total,
  }) async {
    print("DESIRED TOTAL $total");
    if (list[id.toString()] == null) {
      list[id.toString()] = {
        "name": name,
        "url": url,
        "price": price,
        "discount": discount,
        "total": total,
      };
      return list;
    } else {
      print("EXisting ${list[id.toString()]["total"]}");

      list[id.toString()]["total"] = list[id.toString()]["total"] + total;
      return list;
    }
  }

  dynamic _removeItemFromExistingCart({
    required int id,
    required Map list,
    required int total,
  }) async {
    list[id]["total"] = total;

    if (list[id]["total"] <= 0) {
      list.remove(id.toString());
    }
    return list;
  }

  dynamic _addItemToExistingList({
    required int id,
    required String name,
    required String url,
    required double price,
    required double discount,
    required Map list,
  }) async {
    if (list[id] == null) {
      list[id.toString()] = {
        "name": name,
        "url": url,
        "price": price,
        "discount": discount
      };
      return list;
    } else {
      print('elsa');
      return null;
    }
  }

  dynamic _removeItemFromExistingList({
    required int id,
    required Map list,
  }) async {
    print("id yg ingin diremove: $id");

    if (list.isNotEmpty || list[id] != null) {
      list.remove(id.toString());

      return list;
    } else {
      print('elsa');
      return null;
    }
  }
}
