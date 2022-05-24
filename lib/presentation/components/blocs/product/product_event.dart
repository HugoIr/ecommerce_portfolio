part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class CreateProductEvent extends ProductEvent {
  final Item item;
  CreateProductEvent({required this.item});
}
