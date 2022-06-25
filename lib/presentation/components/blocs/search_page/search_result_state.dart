part of 'search_result_bloc.dart';

@immutable
abstract class SearchResultState {}

class SearchResultInitial extends SearchResultState {}

class SearchResultNotFound extends SearchResultState {}

class SearchResultLoading extends SearchResultState {}

class SearchResultLoaded extends SearchResultState {
  final List<Item> results;

  SearchResultLoaded({required this.results});
}
