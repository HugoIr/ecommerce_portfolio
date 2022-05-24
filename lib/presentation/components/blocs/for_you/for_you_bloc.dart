import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/services/product/product_service.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

part 'for_you_event.dart';
part 'for_you_state.dart';

class ForYouBloc extends Bloc<ForYouEvent, ForYouState> {
  UserService userService;
  ProductService productService;
  ForYouBloc({required this.userService, required this.productService})
      : super(ForYouInitial()) {
    on<GetForYouEvent>(_onGetForYou);
    on<AddToWishlistEvent>(_onAddToWishlist);
    on<RemoveToWishlistEvent>(_onRemoveToWishlist);
  }

  List<Item> cloneList(List list) {
    List<Item> newList = [];
    for (int i = 0; i < list.length; i++) {
      Item item = list[i];
      print("item $item");
      newList.add(Item(
        id: item.id,
        name: item.name,
        url: item.url,
        price: item.price,
        discount: item.discount,
        idSeller: item.idSeller,
        sellerName: item.sellerName,
        stock: item.stock,
      ));
    }
    return newList;
  }

  FutureOr<void> _onGetForYou(
      GetForYouEvent event, Emitter<ForYouState> emit) async {
    var listsId = await userService.getListsId();
    print("listId $listsId");

    List<Item> listProduct = await productService.getListProduct();
    List<Item> newList = listProduct.map((item) {
      print("ITEM get for you ${item.name}");
      if (listsId.contains(item.id.toString())) {
        // print("selected item id ${item.id}");
        item.isSelected = true;
      }
      return item;
    }).toList();

    emit(LoadedForYouState(listsItem: newList));
  }

  FutureOr<void> _onAddToWishlist(
      AddToWishlistEvent event, Emitter<ForYouState> emit) async {
    final state = this.state;

    if (state is LoadedForYouState) {
      for (Item item in state.listsItem) {
        if (item.id == event.id) {
          item.isSelected = !item.isSelected;
        }
      }

      userService.addWishlist(
        id: event.id,
        name: event.name,
        url: event.url,
        price: event.price,
        discount: event.discount,
        idSeller: event.idSeller,
        sellerName: event.sellerName,
      );
      emit(LoadedForYouState(listsItem: state.listsItem));
    }
  }

  FutureOr<void> _onRemoveToWishlist(
      RemoveToWishlistEvent event, Emitter<ForYouState> emit) async {
    print("ONREMOVEEEEE;");
    final state = this.state;
    if (state is LoadedForYouState) {
      for (Item item in state.listsItem) {
        if (item.id == event.id) {
          item.isSelected = !item.isSelected;
        }
      }
      userService.removeWishlist(
        id: event.id,
      );
      emit(LoadedForYouState(listsItem: state.listsItem));
    }
  }
}
