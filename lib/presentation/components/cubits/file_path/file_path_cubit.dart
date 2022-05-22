import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'file_path_state.dart';

class FilePathCubit extends Cubit<FilePathState> {
  FilePathCubit() : super(FilePathInitial());

  void changeFilePath(String path) {
    emit(FilePathLoaded(path: path));
  }
}
