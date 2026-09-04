import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'boarding_state.dart';

class BoardingCubit extends Cubit<BoardingState> {
  PageController pageController = PageController();
  double currentPage = 0;

  BoardingCubit() : super(BoardingInitial()) {
    pageController.addListener(() {
      currentPage = pageController.page!;
      emit(BoardingPageChanged(currentPage: currentPage));
    });
  }
}
