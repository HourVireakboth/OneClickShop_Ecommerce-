// ignore_for_file: must_be_immutable

part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
   FavoriteState({this.favorite});
  List<FavoriteModel>? favorite= [];
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteCompleted extends FavoriteState {
  List<FavoriteModel>? itemsFavorite;
  FavoriteCompleted({this.itemsFavorite}):super(favorite: itemsFavorite);
}

class FavoriteLoading extends FavoriteState {}

class FaroriteError extends FavoriteState {
  var error;
  FaroriteError({this.error});
}
