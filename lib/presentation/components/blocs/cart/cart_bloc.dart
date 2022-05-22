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
    on<GetCartEvent>(_onGetCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveCartItemEvent>(_onRemoveCartItem);
  }
  FutureOr<void> _onGetCart(GetCartEvent event, Emitter<CartState> emit) async {
    final result = await userService.getListOfCurrentCart();
    print("succesful fetch $result");
    emit(LoadedCartState(listsItem: result));
  }

  FutureOr<void> _onAddToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    await userService.addToCart(
      id: event.id,
      name: event.name,
      url: event.url,
      price: event.price,
      discount: event.discount,
      total: event.total,
      idSeller: event.idSeller,
      sellerName: event.sellerName,
      stock: event.stock,
    );
  }

  FutureOr<void> _onRemoveCartItem(
      RemoveCartItemEvent event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is LoadedCartState) {
      List<CartItem> list = state.listsItem;
      list.removeAt(event.index);
      await userService.removeCartItem(id: event.id);

      emit(LoadedCartState(listsItem: state.listsItem));
    }
  }
}
