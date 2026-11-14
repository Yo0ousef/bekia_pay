import 'package:bekia_pay/features/materials/domain/entities/material_entity.dart';
import 'package:bekia_pay/features/materials/domain/use_cases/get_materials_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'materials_cubit.freezed.dart';

part 'materials_state.dart';

class MaterialsCubit extends Cubit<MaterialsState> {
  final GetMaterialsUseCase _getMaterials;

  MaterialsCubit(this._getMaterials) : super(const MaterialsState.loading()) {
    getMaterials();
  }

  Future<void> getMaterials() async {
    if (state is! _Loading) emit(const MaterialsState.loading());
    try {
      final materials = await _getMaterials();
      if (!isClosed) emit(MaterialsState.success(materials));
    } catch (error) {
      if (!isClosed) emit(MaterialsState.failure(error.toString()));
    }
  }
}
