part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class LoadedCartState extends CartInitial {
  final List<CartItem> listsItem;
  LoadedCartState({required this.listsItem});
}
