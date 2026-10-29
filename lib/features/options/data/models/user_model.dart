import 'package:bekia_pay/core/utils/extensions/json_parser_extension.dart';
import 'package:bekia_pay/features/options/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String fullName;
  final String? email;
  final String? role;
  final String? phone;
  final String? governorate;
  final String? city;
  final String? street;
  final String? houseNumber;
  final String? floor;
  final String? apartmentNumber;
  final int pointsBalance;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.pointsBalance,
    this.email,
    this.role,
    this.phone,
    this.governorate,
    this.city,
    this.street,
    this.houseNumber,
    this.floor,
    this.apartmentNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    const contextName = 'profiles';
    final points = json['points_balance'];
    if (points is! num || !points.isFinite || points < 0 || points % 1 != 0) {
      throw const FormatException(
        'profiles.points_balance must be a non-negative whole number',
      );
    }

    return UserModel(
      id: json.parseRequiredString('id', contextName: contextName),
      fullName: json.parseRequiredString('full_name', contextName: contextName),
      pointsBalance: points.toInt(),
      email: json.parseOptionalString('email', contextName: contextName),
      role: json.parseOptionalString('role', contextName: contextName),
      phone: json.parseOptionalString('phone', contextName: contextName),
      governorate: json.parseOptionalString(
        'governorate',
        contextName: contextName,
      ),
      city: json.parseOptionalString('city', contextName: contextName),
      street: json.parseOptionalString('street', contextName: contextName),
      houseNumber: json.parseOptionalString(
        'house_number',
        contextName: contextName,
      ),
      floor: json.parseOptionalString('floor', contextName: contextName),
      apartmentNumber: json.parseOptionalString(
        'apartment_number',
        contextName: contextName,
      ),
    );
  }

  factory UserModel.fromEntity(UserEntity user) => UserModel(
    id: user.id,
    fullName: user.fullName,
    email: user.email,
    role: user.role,
    phone: user.phone,
    governorate: user.governorate,
    city: user.city,
    street: user.street,
    houseNumber: user.houseNumber,
    floor: user.floor,
    apartmentNumber: user.apartmentNumber,
    pointsBalance: user.pointsBalance,
  );

  UserEntity toEntity() => UserEntity(
    id: id,
    fullName: fullName,
    email: email,
    role: role,
    phone: phone,
    governorate: governorate,
    city: city,
    street: street,
    houseNumber: houseNumber,
    floor: floor,
    apartmentNumber: apartmentNumber,
    pointsBalance: pointsBalance,
  );

  Map<String, dynamic> toProfileUpdateJson() => {
    'full_name': fullName,
    'phone': phone,
    'governorate': governorate,
    'city': city,
    'street': street,
    'house_number': houseNumber,
    'floor': floor,
    'apartment_number': apartmentNumber,
  };
}
