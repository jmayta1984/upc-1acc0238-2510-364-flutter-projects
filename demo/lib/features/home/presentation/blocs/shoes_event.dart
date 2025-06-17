abstract class ShoesEvent {
  const ShoesEvent();
}

class GetShoesEvent extends ShoesEvent {}

class GetShoeByIdEvent extends ShoesEvent {
  final int id;
  const GetShoeByIdEvent({required this.id});
}
