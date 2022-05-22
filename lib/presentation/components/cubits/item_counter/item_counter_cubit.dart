import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class ItemCounterCubit extends Cubit<int> {
  int initialCount;
  ItemCounterCubit({required this.initialCount}) : super(initialCount);

  void increaseCounter() {
    emit(state + 1);
  }

  void changeCounter(var number) {
    if (number == "") {
      emit(1);
    } else if (number is int) {
      emit(number);
    } else {
      emit(int.parse(number));
    }
  }

  void decreaseCounter() {
    if (state > 1) {
      emit(state - 1);
    }
  }
}
