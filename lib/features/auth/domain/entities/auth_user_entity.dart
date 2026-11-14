class AuthUserEntity {
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

  const AuthUserEntity({
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
}
