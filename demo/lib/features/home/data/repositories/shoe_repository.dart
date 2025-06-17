import 'package:demo/features/home/data/datasources/shoe_service.dart';
import 'package:demo/features/home/domain/entities/shoe.dart';

class ShoeRepository {
  final ShoeService shoeService = ShoeService();

  Future<List<Shoe>> getShoes() async {
    final List<Shoe> shoes = (await shoeService.getShoes())
        .map((shoeDto) => shoeDto.toDomain())
        .toList();
    return shoes;
  }

  Future<Shoe> getShoeById(int id) async {
    final Shoe shoe = (await shoeService.getShoeById(id)).toDomain();
    return shoe;
  }
}
