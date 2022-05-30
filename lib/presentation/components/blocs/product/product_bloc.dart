import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/seller/my_product/my_product_bloc.dart';
import 'package:funesia_clone/presentation/pages/seller/product/my_product.dart';
import 'package:funesia_clone/services/product/product_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductService productService;
  ForYouBloc forYouBloc;
  MyProductBloc myProductBloc;

  ProductBloc(
      {required this.productService,
      required this.forYouBloc,
      required this.myProductBloc})
      : super(ProductInitial()) {
    on<CreateProductEvent>(_onCreateProduct);
    // on<UploadProductImageEvent>(_onUploadProductImage);
  }

  void _onCreateProduct(
      CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductCreating());
    TaskSnapshot imageSnapshot =
        await uploadProductImage(event.fileImage, event.id);
    String urlImage = await imageSnapshot.ref.getDownloadURL();
    print("imageSnapshot URLIMAGE $urlImage");
    Item item = Item(
      id: event.id,
      idSeller: event.idSeller,
      sellerName: event.sellerName,
      name: event.name,
      price: double.parse(event.price),
      discount: (event.discount != null) ? double.parse(event.discount) : null,
      stock: int.parse(event.stock),
      url: urlImage,
    );
    await productService.createProduct(item);
    print("after create produc");
    addItemToForYouList(item);
    addToMyProduct(item);
    emit(ProductCreated());
  }

  void addToMyProduct(Item item) {
    // final myProductState = myProductBloc.state;
    // if (myProductState is MyProductLoaded) {

    // }
    myProductBloc..add(NewProductCreatedEvent(item: item));
  }

  void addItemToForYouList(Item item) {
    final forYouState = forYouBloc.state;
    if (forYouState is LoadedForYouState) {
      List<Item> listsItem = forYouState.listsItem;
      listsItem.add(item);
      print("after add to foryou");
    }
  }

  dynamic uploadProductImage(XFile file, String idProduct) async {
    final result = await productService.uploadImageToFirebase(file, idProduct);
    print("result upload $result");
    return result;
  }
}
