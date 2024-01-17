part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  final bool isLastPage;

  const OnBoardingState({
    this.isLastPage = false,
  });

  OnBoardingState copyWith({
    bool? isLastPage,
  }) {
    return OnBoardingState(
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object?> get props => [isLastPage];
}
