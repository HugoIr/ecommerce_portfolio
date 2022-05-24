part of 'for_you_bloc.dart';

@immutable
abstract class ForYouEvent {}

class GetForYouEvent extends ForYouEvent {
  // final List<Item> list;
  // GetForYouEvent({required this.list});
}

class AddToWishlistEvent extends ForYouEvent {
  final String id;
  final String name;
  final String url;
  final double price;
  final double discount;
  final String idSeller;
  final String sellerName;
  AddToWishlistEvent({
    required this.id,
    required this.name,
    required this.url,
    required this.price,
    required this.discount,
    required this.idSeller,
    required this.sellerName,
  });
}

class RemoveToWishlistEvent extends ForYouEvent {
  final String id;

  RemoveToWishlistEvent({required this.id});
}
