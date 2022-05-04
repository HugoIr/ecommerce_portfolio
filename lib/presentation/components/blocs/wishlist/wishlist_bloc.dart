import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  UserService userService;
  WishlistBloc({required this.userService}) : super(WishlistInitial()) {
    on<AddToWishlistEvent>(_onAddToWishlist);
  }

  FutureOr<void> _onAddToWishlist(
      AddToWishlistEvent event, Emitter<WishlistState> emit) async {
    userService.addWishlist(
      id: event.id,
      name: event.name,
      url: event.url,
      price: event.price,
      discount: event.discount,
    );
    // print("BLOC wishlist ${await userService.getCurrentWishlist()}");
    emit(WishlistAddedState());
  }
}
