part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductCreating extends ProductState {}

class ProductCreated extends ProductState {}
