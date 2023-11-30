import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oneclickshop/model/Products/product.dart';
import 'package:oneclickshop/repository/search/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository = SearchRepository();
  SearchBloc() : super(SearchInitial()) {
    on<SearchProduct>((event, emit) async {
      var token = event.token;
      var name = event.name;

      try {
        emit(SearchLoading());
        List<Result> responseBody =
            await searchRepository.searchProduct(token, name);
        print("search list = ${responseBody.length}");
        emit(SearchCompleted(searchList: responseBody));
      } catch (error) {
        emit(SearchError(error: error.toString()));
      }
    });
  }
}
