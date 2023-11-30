// ignore_for_file: must_be_immutable

part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
  @override
  List<Object> get props => [];
}

class FetchsFavorite extends FavoriteEvent {
  var token;
   FetchsFavorite({this.token});
}

class AddFavorite extends FavoriteEvent {
  var token;
  var productID;
  AddFavorite({this.token,this.productID});
}

class RemoveFavorite extends FavoriteEvent {
  var token;
  var favoriteID;
  RemoveFavorite({this.token,this.favoriteID});
}
