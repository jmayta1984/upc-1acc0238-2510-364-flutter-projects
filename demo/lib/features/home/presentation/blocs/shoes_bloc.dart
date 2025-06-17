import 'package:demo/features/home/data/repositories/shoe_repository.dart';
import 'package:demo/features/home/domain/entities/shoe.dart';
import 'package:demo/features/home/presentation/blocs/shoes_event.dart';
import 'package:demo/features/home/presentation/blocs/shoes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoesBloc extends Bloc<ShoesEvent, ShoesState> {
  final _repository = ShoeRepository();
  ShoesBloc() : super(InitialShoesState()) {
    on<GetShoesEvent>((event, emit) async {
      emit(LoadingShoesState());
      try {
        List<Shoe> shoes = await _repository.getShoes();
        emit(SuccessShoesState(shoes: shoes));
      } catch (e) {
        emit(FailureShoesState(errorMessage: e.toString()));
      }
    });

    on<GetShoeByIdEvent>((event, emit) async {
      try {
        Shoe shoe = await _repository.getShoeById(event.id);
        emit(LoadedShoeState(shoe: shoe));
      } catch (e) {
        emit(FailureShoesState(errorMessage: e.toString()));
      }
    });
  }
}
