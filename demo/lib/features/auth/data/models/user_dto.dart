import 'package:demo/features/auth/domain/entities/user.dart';

class UserDto {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String image;

  const UserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
    );
  }

  User toDomain() {
    return User(
      id: id.toString(),
      email: email,
      username: username,
      name: '$firstName $lastName',
      image: image,
    );
  }
}
