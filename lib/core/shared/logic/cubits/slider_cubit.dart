import 'package:flutter_bloc/flutter_bloc.dart';

class IndexChangerCubit extends Cubit<int> {
  IndexChangerCubit() : super(0);

  void changeIndex(int index) => emit(index);
}
