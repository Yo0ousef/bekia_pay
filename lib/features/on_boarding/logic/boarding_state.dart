part of 'boarding_cubit.dart';

abstract class BoardingState {}

final class BoardingInitial extends BoardingState {}

final class BoardingPageChanged extends BoardingState {
  final double currentPage;

  BoardingPageChanged({required this.currentPage});
}
