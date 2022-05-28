part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class CreateProductEvent extends ProductEvent {
  final String id;
  final String idSeller;
  final String sellerName;
  final String name;
  final String price;
  final dynamic? discount;
  final String stock;
  final XFile fileImage;

  CreateProductEvent(
      {required this.id,
      required this.idSeller,
      required this.sellerName,
      required this.name,
      required this.price,
      required this.discount,
      required this.stock,
      required this.fileImage});
}

class UploadProductImageEvent extends ProductEvent {
  final XFile file;
  final String idProduct;
  UploadProductImageEvent({required this.file, required this.idProduct});
}
