import 'package:demo/features/home/data/repositories/shoe_repository.dart';
import 'package:demo/features/home/domain/entities/shoe.dart';
import 'package:demo/features/home/presentation/blocs/shoes_event.dart';
import 'package:demo/features/home/presentation/blocs/shoes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoesBloc extends Bloc<ShoesEvent, ShoesState> {
  ShoesBloc() : super(InitialShoesState()) {
    on<GetShoesEvent>((event, emit) async {
      emit(LoadingShoesState());
      //await Future.delayed(const Duration(milliseconds: 2000));
      try {
        List<Shoe> shoes = await ShoeRepository().getShoes();
        emit(SuccessShoesState(shoes: shoes));
      } catch (e) {
        emit(FailureShoesState(errorMessage: e.toString()));
      }
    });
  }
}
