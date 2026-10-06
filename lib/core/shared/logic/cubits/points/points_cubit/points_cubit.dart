import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_cubit.freezed.dart';
part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  final PointsRepo _repo;

  PointsCubit(this._repo) : super(const PointsState.loading()) {
    getPoints();
  }

  void getPoints() async {
    final result = await _repo.getPoints();
    if (isClosed) return;
    result.when(
      success: (points) {
        emit(PointsState.success(points));
      },
      failure: (message) {
        emit(PointsState.failure(message));
      },
    );
  }
}
