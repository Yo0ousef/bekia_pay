import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/materials/data/materials_repo.dart';
import 'package:bekia_pay/features/materials/data/models/material_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'materials_cubit.freezed.dart';

part 'materials_state.dart';

class MaterialsCubit extends Cubit<MaterialsState> {
  final MaterialsRepo _materialsRepo;

  MaterialsCubit(this._materialsRepo) : super(const MaterialsState.loading()) {
    getMaterials();
  }

  void getMaterials() async {
    final ApiResult<List<MaterialModel>> materials = await _materialsRepo
        .fetchMaterials();
    materials.when(
      success: (materials) => emit(MaterialsState.success(materials)),
      failure: (message) => emit(MaterialsState.failure(message)),
    );
  }
}
