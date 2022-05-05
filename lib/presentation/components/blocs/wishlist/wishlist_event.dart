part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class GetWishlistEvent extends WishlistEvent {}

// class AddToWishlistEvent extends WishlistEvent {
//   final int id;
//   final String name;
//   final String url;
//   final double price;
//   final double discount;
//   AddToWishlistEvent(
//       {required this.id,
//       required this.name,
//       required this.url,
//       required this.price,
//       required this.discount});
// }
