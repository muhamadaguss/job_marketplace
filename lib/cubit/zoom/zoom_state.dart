part of 'zoom_cubit.dart';

class ZoomState extends Equatable {
  final int selectedIndex;
  const ZoomState({
    this.selectedIndex = 0,
  });

  ZoomState copyWith({
    int? selectedIndex,
  }) {
    return ZoomState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}
