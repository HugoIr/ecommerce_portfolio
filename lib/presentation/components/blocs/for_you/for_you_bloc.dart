import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

part 'for_you_event.dart';
part 'for_you_state.dart';

class ForYouBloc extends Bloc<ForYouEvent, ForYouState> {
  UserService userService;

  ForYouBloc({required this.userService}) : super(ForYouInitial()) {
    on<GetForYouEvent>(_onGetForYou);
    on<AddToWishlistEvent>(_onAddToWishlist);
    on<RemoveToWishlistEvent>(_onRemoveToWishlist);
  }

  FutureOr<void> _onGetForYou(
      GetForYouEvent event, Emitter<ForYouState> emit) async {
    print("BRUDHH");
    var listsId = await userService.getListsId();
    print("listId $listsId");
    List<Item> newList = event.list.map((item) {
      if (listsId.contains(item.id.toString())) {
        print("selected item id ${item.id}");
        item.isSelected = true;
      }
      return item;
    }).toList();
    emit(LoadedForYouState(listsItem: newList));
  }

  FutureOr<void> _onAddToWishlist(
      AddToWishlistEvent event, Emitter<ForYouState> emit) async {
    final state = this.state;

    if (state is LoadedForYouState) {
      final newLists = state.listsItem.map((item) {
        if (item.id == event.id) {
          print("isselected with item id ${item.id}");
          item.isSelected = true;
        }
        return item;
      }).toList();

      userService.addWishlist(
        id: event.id,
        name: event.name,
        url: event.url,
        price: event.price,
        discount: event.discount,
      );
      emit(LoadedForYouState(listsItem: newLists));
    }
  }

  FutureOr<void> _onRemoveToWishlist(
      RemoveToWishlistEvent event, Emitter<ForYouState> emit) async {
    print("ONREMOVEEEEE;");
    final state = this.state;
    if (state is LoadedForYouState) {
      final newLists = state.listsItem.map((item) {
        if (item.id == event.id) {
          print("isselected to remove with item id ${item.id}");
          item.isSelected = false;
        }
        return item;
      }).toList();

      userService.removeWishlist(
        id: event.id,
      );
      emit(LoadedForYouState(listsItem: newLists));
    }
  }
}
