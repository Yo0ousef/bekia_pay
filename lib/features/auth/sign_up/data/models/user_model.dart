class UserModel {
  final String fullName,
      role,
      city,
      phone,
      email,
      floor,
      street,
      governorate,
      houseNumber,
      pointsBalance,
      apartmentNumber;

  UserModel({
    required this.fullName,
    required this.phone,
    required this.governorate,
    required this.email,
    required this.pointsBalance,
    required this.role,
    required this.city,
    required this.street,
    required this.houseNumber,
    required this.floor,
    required this.apartmentNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json["full_name"],
      phone: json["phone"],
      governorate: json["governorate"],
      email: json["email"],
      pointsBalance: json["points_balance"],
      role: json["role"],
      city: json["city"],
      street: json["street"],
      houseNumber: json["house_number"],
      floor: json["floor"],
      apartmentNumber: json["apartment_number"],
    );
  }

  Map<String, dynamic> toJson(UserModel user) {
    return {
      "full_name": user.fullName,
      "phone": user.phone,
      "governorate": user.governorate,
      "email": user.email,
      "points_balance": user.pointsBalance,
      "role": user.role,
      "city": user.city,
      "street": user.street,
      "house_number": user.houseNumber,
      "floor": user.floor,
      "apartment_number": user.apartmentNumber,
    };
  }
}
