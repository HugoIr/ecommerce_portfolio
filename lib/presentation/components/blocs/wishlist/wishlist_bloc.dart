import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  UserService userService;
  WishlistBloc({required this.userService}) : super(WishlistInitial()) {
    on<GetWishlistEvent>(_onGetWishlist);
    on<ClickWishlistEvent>(_onClickWishlistEvent);
  }

  FutureOr<void> _onGetWishlist(
      GetWishlistEvent event, Emitter<WishlistState> emit) async {
    var results = await userService.getListOfCurrentWishlist();
    var listsId = await userService.getListsId();
    results = results.map((item) {
      if (listsId.contains(item.id.toString())) {
        ;
        item.isSelected = true;
      }
      return item;
    }).toList();
    print("RESULT $results");
    emit(WishlistLoadedState(listsItem: results));
  }

  // FutureOr<void> _onAddToWishlist(
  //     AddToWishlistEvent event, Emitter<WishlistState> emit) async {
  //   userService.addWishlist(
  //     id: event.id,
  //     name: event.name,
  //     url: event.url,
  //     price: event.price,
  //     discount: event.discount,
  //   );
  //   // print("BLOC wishlist ${await userService.getCurrentWishlist()}");
  //   emit(WishlistAddedState());
  // }

  FutureOr<void> _onClickWishlistEvent(
      ClickWishlistEvent event, Emitter<WishlistState> emit) {
    final state = this.state;
    if (state is WishlistLoadedState) {
      // for (Item item in state.listsItem) {
      //   if (item.id == event.id) {
      //     item.isSelected = !item.isSelected;
      //   }
      // }
      state.listsItem[event.index].isSelected =
          !state.listsItem[event.index].isSelected;
      emit(WishlistLoadedState(listsItem: state.listsItem));
    }
  }
}
