part of 'file_path_cubit.dart';

@immutable
abstract class FilePathState {}

class FilePathInitial extends FilePathState {}

class FilePathLoaded extends FilePathState {
  final String path;
  FilePathLoaded({required this.path});
}
