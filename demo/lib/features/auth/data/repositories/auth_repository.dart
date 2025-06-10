import 'package:demo/features/auth/data/datasources/auth_service.dart';
import 'package:demo/features/auth/domain/entities/user.dart';

class AuthRepository {
  final AuthService authService = AuthService();

  Future<User> login(String username, String password) async {
    return (await authService.login(username, password)).toDomain();
  }
}
