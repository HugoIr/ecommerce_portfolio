part of 'my_product_bloc.dart';

@immutable
abstract class MyProductEvent {}

class GetMyProductEvent extends MyProductEvent {}

class NewProductCreatedEvent extends MyProductEvent {
  final Item item;

  NewProductCreatedEvent({required this.item});
}
