import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oneclickshop/model/favorite/favorite.dart';
import 'package:oneclickshop/repository/favorite/favrotite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteRepository favoriteRepository = FavoriteRepository();
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FetchsFavorite>((event, emit) async {
      var token = event.token;
      try {
        emit(FavoriteLoading());
        List<FavoriteModel> responsebody =
            await favoriteRepository.getFavoriteAll(token);
        print("list = ${responsebody[0].product}");
        emit(FavoriteCompleted(itemsFavorite: responsebody));
      } catch (error) {
        print(error.toString());
        emit(FaroriteError(error: error.toString()));
      }
    });

    on<AddFavorite>((event, emit) async {
      var token = event.token;
      var productID = event.productID;
      List<FavoriteModel>? curr = state.favorite ?? [];
      try {
        var responsebody =
            await favoriteRepository.addFavorite(token, productID);
        curr.add(responsebody);
        print("addlist = ${curr.length} ");
        emit(FavoriteLoading());
        emit(FavoriteCompleted(itemsFavorite: curr));
      } catch (error) {
        print(error.toString());
        emit(FaroriteError(error: error.toString()));
      }
    });

    on<RemoveFavorite>((event, emit) async {
      var token = event.token;
      var favoriteID = event.favoriteID;
      try {
        print("listfavorite: ${state.favorite?.length}");
        print("favoriteID=$favoriteID");
        List<FavoriteModel>? curr = state.favorite;
        var isremove = false;
        int index = -1;
        state.favorite?.forEach((element) {
          if (element.id.toString() == favoriteID) {
            isremove = true;
            print("isremove : $isremove");
            print(element);
            index = state.favorite!.indexOf(element);
          }
        });
        print("index: $index");
        print("isremove : $isremove");
        if (isremove == true) {
          print("Already existed");
          curr?.removeAt(index);
          await favoriteRepository.deleteFavorite(token, favoriteID);
          emit(FavoriteLoading());
        }
        emit(FavoriteCompleted(itemsFavorite: curr));
      } catch (error) {
        print(error.toString());
        emit(FaroriteError(error: error.toString()));
      }
    });
  }
}
