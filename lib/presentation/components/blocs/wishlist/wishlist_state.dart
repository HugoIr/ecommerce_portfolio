part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoadedState extends WishlistState {
  final List<Item> listsItem;
  WishlistLoadedState({required this.listsItem});
}
