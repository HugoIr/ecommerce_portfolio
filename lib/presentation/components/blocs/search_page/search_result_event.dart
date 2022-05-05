part of 'search_result_bloc.dart';

@immutable
abstract class SearchResultEvent {}

class SearchEvent extends SearchResultEvent {
  final String keyword;
  SearchEvent({required this.keyword});
}

class RefreshSearchEvent extends SearchResultEvent {
  final int id;
  RefreshSearchEvent({required this.id});
}
