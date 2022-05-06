import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  UserService userService;
  CartBloc({required this.userService}) : super(CartInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  FutureOr<void> _onAddToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    await userService.addToCart(
        id: event.id,
        name: event.name,
        url: event.url,
        price: event.price,
        discount: event.discount);
  }

  FutureOr<void> _onRemoveFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    if (state is LoadedCartState) {
      await userService.removeFromCart(id: event.id);
    }
  }
}
