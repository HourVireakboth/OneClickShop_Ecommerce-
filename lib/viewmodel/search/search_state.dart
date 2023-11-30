// ignore_for_file: must_be_immutable

part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchCompleted extends SearchState {
  List<Result>? searchList = [];
  SearchCompleted({this.searchList});
}

class SearchError extends SearchState {
  var error;
  SearchError({this.error});
}
