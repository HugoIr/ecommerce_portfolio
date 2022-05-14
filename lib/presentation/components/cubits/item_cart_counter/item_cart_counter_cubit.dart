import 'package:bloc/bloc.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

class ItemCartCounterCubit extends Cubit<int> {
  UserService userService;
  ItemCartCounterCubit({required this.userService}) : super(1);

  void increaseCounter(int id) {
    userService.addCart(id: id);
    emit(state + 1);
  }

  void changeCounter(var number, int id) {
    if (number == "") {
      userService.updateCartTotal(id: id, total: 1);
      emit(1);
    } else {
      userService.updateCartTotal(id: id, total: int.parse(number));
      emit(int.parse(number));
    }
  }

  void decreaseCounter(int id) {
    if (state > 1) {
      userService.reduceCart(id: id);
      emit(state - 1);
    }
  }
}
