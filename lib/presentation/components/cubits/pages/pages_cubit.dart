import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class PagesCubit extends Cubit<int> {
  PagesCubit() : super(0);

  void changePage(int index) {
    emit(index);
  }
}
