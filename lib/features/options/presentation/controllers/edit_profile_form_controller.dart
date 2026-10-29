import 'package:bekia_pay/features/options/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class EditProfileFormController {
  final UserEntity originalUser;
  final formKey = GlobalKey<FormState>();
  late final nameController = TextEditingController(text: originalUser.fullName);
  late String phone = originalUser.phone ?? '';
  late final governorateController = TextEditingController(
    text: originalUser.governorate ?? '',
  );
  late final cityController = TextEditingController(text: originalUser.city ?? '');
  late final streetController = TextEditingController(
    text: originalUser.street ?? '',
  );
  late final houseNumberController = TextEditingController(
    text: originalUser.houseNumber ?? '',
  );
  late final floorController = TextEditingController(
    text: originalUser.floor ?? '',
  );
  late final apartmentNumberController = TextEditingController(
    text: originalUser.apartmentNumber ?? '',
  );

  EditProfileFormController(this.originalUser);

  UserEntity toUpdatedEntity() => UserEntity(
    id: originalUser.id,
    fullName: nameController.text.trim(),
    email: originalUser.email,
    role: originalUser.role,
    phone: phone.trim(),
    governorate: governorateController.text.trim(),
    city: cityController.text.trim(),
    street: streetController.text.trim(),
    houseNumber: houseNumberController.text.trim(),
    floor: floorController.text.trim(),
    apartmentNumber: apartmentNumberController.text.trim(),
    pointsBalance: originalUser.pointsBalance,
  );

  void dispose() {
    nameController.dispose();
    governorateController.dispose();
    cityController.dispose();
    streetController.dispose();
    houseNumberController.dispose();
    floorController.dispose();
    apartmentNumberController.dispose();
  }
}
