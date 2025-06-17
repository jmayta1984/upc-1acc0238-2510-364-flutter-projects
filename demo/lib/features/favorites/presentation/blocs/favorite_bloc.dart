import 'package:demo/features/favorites/data/repositories/favorite_shoe_repository.dart';
import 'package:demo/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:demo/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteShoeRepository _repository = FavoriteShoeRepository();
  FavoriteBloc() : super(InitialFavoriteState()) {
    on<AddFavoriteEvent>((event, emit) async {
      await _repository.insertFavorite(event.favorite);
      final favorites = await _repository.fetchAll();
      emit(LoadedFavoriteState(favorites: favorites));
    });

    on<RemoveFavoriteEvent>((event, emit) async {
      await _repository.deleteFavorite(event.id);
      final favorites = await _repository.fetchAll();
      emit(LoadedFavoriteState(favorites: favorites));
    });

    on<GetAllFavoriteEvent>((event, emit) async {
      final favorites = await _repository.fetchAll();
      emit(LoadedFavoriteState(favorites: favorites));
    });

    on<IsFavoriteEvent>((event, emit) async {
      final isFavorite = await _repository.isFavorite(event.id);
      emit(IsFavoriteState(isFavorite: isFavorite));
    });

    on<OnToggleFavoriteEvent>((event, emit) async {
      final favorite = event.favorite;
      final isFavorite = await _repository.isFavorite(favorite.id);
      if (isFavorite) {
        await _repository.deleteFavorite(favorite.id);
      } else {
        await _repository.insertFavorite(favorite);
      }
      emit(IsFavoriteState(isFavorite: !isFavorite));
    });
  }
}
