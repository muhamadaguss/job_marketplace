import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'zoom_state.dart';

class ZoomCubit extends Cubit<ZoomState> {
  ZoomCubit() : super(const ZoomState());

  void setIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
