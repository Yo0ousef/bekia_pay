class UserEntity {
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

  const UserEntity({
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
}
