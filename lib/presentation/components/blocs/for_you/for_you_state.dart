part of 'for_you_bloc.dart';

@immutable
abstract class ForYouState {}

class ForYouInitial extends ForYouState {}

class LoadedForYouState extends ForYouState {
  final List<Item> listsItem;

  LoadedForYouState({required this.listsItem});
}
