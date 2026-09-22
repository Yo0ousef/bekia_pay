part of 'materials_cubit.dart';

@freezed
class MaterialsState with _$MaterialsState {
  const factory MaterialsState.loading() = _Loading;

  const factory MaterialsState.success(List<MaterialModel> materials) =
      _Success;

  const factory MaterialsState.failure(String message) = _Failure;
}
