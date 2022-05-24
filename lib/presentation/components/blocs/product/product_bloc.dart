import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/services/product/product_service.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductService productService;
  ProductBloc({required this.productService}) : super(ProductInitial()) {
    on<CreateProductEvent>(_onCreateProduct);
  }

  void _onCreateProduct(
      CreateProductEvent event, Emitter<ProductState> emit) async {
    await productService.createProduct(event.item);
    print("after create produc");
  }
}
