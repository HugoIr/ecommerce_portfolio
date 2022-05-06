part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final int id;
  final int index;
  final String name;
  final String url;
  final double price;
  final double discount;

  AddToCartEvent({
    required this.id,
    required this.index,
    required this.name,
    required this.url,
    required this.price,
    required this.discount,
  });
}

class RemoveFromCartEvent extends CartEvent {
  final int index;
  final int id;
  RemoveFromCartEvent({required this.id, required this.index});
}
