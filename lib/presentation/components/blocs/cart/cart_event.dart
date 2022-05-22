part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class GetCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final int id;
  final int index;
  final String name;
  final String url;
  final double price;
  final double discount;
  final int total;
  final String idSeller;
  final String sellerName;
  final int stock;

  AddToCartEvent({
    required this.id,
    required this.index,
    required this.name,
    required this.url,
    required this.price,
    required this.discount,
    required this.total,
    required this.idSeller,
    required this.sellerName,
    required this.stock,
  });
}

class RemoveCartItemEvent extends CartEvent {
  final int id;
  final int index;
  RemoveCartItemEvent({
    required this.id,
    required this.index,
  });
}
