import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavigationCubit extends Cubit<int> {
  HomeNavigationCubit() : super(0);

  void changeTab(int index) {
    if (index >= 0 && index < 3) emit(index);
  }
}

class OffersCarouselCubit extends Cubit<int> {
  OffersCarouselCubit() : super(0);

  void changePage(int index) => emit(index);
}
