import 'package:bekia_pay/features/auth/domain/entities/auth_user_entity.dart';

class AuthUserModel {
  final String fullName;
  final String role;
  final String city;
  final String phone;
  final String email;
  final String floor;
  final String street;
  final String governorate;
  final String houseNumber;
  final String apartmentNumber;
  final int pointsBalance;

  const AuthUserModel({
    required this.fullName,
    required this.role,
    required this.city,
    required this.phone,
    required this.email,
    required this.floor,
    required this.street,
    required this.governorate,
    required this.houseNumber,
    required this.apartmentNumber,
    required this.pointsBalance,
  });

  factory AuthUserModel.fromEntity(AuthUserEntity user) => AuthUserModel(
    fullName: user.fullName,
    role: user.role,
    city: user.city,
    phone: user.phone,
    email: user.email,
    floor: user.floor,
    street: user.street,
    governorate: user.governorate,
    houseNumber: user.houseNumber,
    apartmentNumber: user.apartmentNumber,
    pointsBalance: user.pointsBalance,
  );

  Map<String, dynamic> toJson({required String id}) => {
    'id': id,
    'full_name': fullName,
    'phone': phone,
    'governorate': governorate,
    'email': email,
    'points_balance': pointsBalance,
    'role': role,
    'city': city,
    'street': street,
    'house_number': houseNumber,
    'floor': floor,
    'apartment_number': apartmentNumber,
  };
}
