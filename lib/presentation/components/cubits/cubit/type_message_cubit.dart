import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class TypeMessageCubit extends Cubit<bool> {
  TypeMessageCubit() : super(false);

  void onType(String text) {
    if (text.length > 0) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
