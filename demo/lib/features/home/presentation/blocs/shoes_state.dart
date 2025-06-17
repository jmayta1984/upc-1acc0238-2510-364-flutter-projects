import 'package:demo/features/home/domain/entities/shoe.dart';

abstract class ShoesState {
  const ShoesState();
}

class InitialShoesState extends ShoesState {}

class LoadingShoesState extends ShoesState {}

class SuccessShoesState extends ShoesState {
  final List<Shoe> shoes;
  const SuccessShoesState({required this.shoes});
}

class FailureShoesState extends ShoesState {
  final String errorMessage;
  const FailureShoesState({required this.errorMessage});
}

class LoadedShoeState extends ShoesState {
  final Shoe shoe;
  const LoadedShoeState({required this.shoe});
}
