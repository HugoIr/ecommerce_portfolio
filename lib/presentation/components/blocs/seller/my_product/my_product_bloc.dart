import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/user/user_bloc.dart';
import 'package:meta/meta.dart';

part 'my_product_event.dart';
part 'my_product_state.dart';

class MyProductBloc extends Bloc<MyProductEvent, MyProductState> {
  ForYouBloc forYouBloc;
  UserBloc userBloc;
  late StreamSubscription _forYouSubscription;
  MyProductBloc({required this.forYouBloc, required this.userBloc})
      : super(MyProductInitial()) {
    on<GetMyProductEvent>(_onGetMyProduct);
    on<NewProductCreatedEvent>(_onNewProductCreated);
    _forYouSubscription = forYouBloc.stream.listen((event) {
      print("Event from FORYOU subscription $event");
      add(GetMyProductEvent());
    });
  }

  FutureOr<void> _onGetMyProduct(
      GetMyProductEvent event, Emitter<MyProductState> emit) {
    final forYouState = forYouBloc.state;
    final userState = userBloc.state;

    if (forYouState is LoadedForYouState &&
        userState is UserLoaded &&
        userState.userInfo!.isSeller) {
      List<Item> listsItem = forYouState.listsItem
          .where((element) => element.idSeller == userState.userInfo!.uid)
          .toList();
      print("LISTITEM $listsItem");
      emit(MyProductLoaded(listsItem: listsItem));
    }
  }

  FutureOr<void> _onNewProductCreated(
      NewProductCreatedEvent event, Emitter<MyProductState> emit) {
    final state = this.state;
    print("_onNewProductCreated");
    if (state is MyProductLoaded) {
      print("MyProductLoaded _onNewProductCreated");
      List<Item> listsItem = state.listsItem;
      listsItem.add(event.item);
      emit(MyProductLoaded(listsItem: listsItem));
    }
  }
}
