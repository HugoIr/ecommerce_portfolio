part of 'my_product_bloc.dart';

@immutable
abstract class MyProductState {}

class MyProductInitial extends MyProductState {}

class MyProductLoaded extends MyProductState {
  final List<Item> listsItem;

  MyProductLoaded({required this.listsItem});
}
