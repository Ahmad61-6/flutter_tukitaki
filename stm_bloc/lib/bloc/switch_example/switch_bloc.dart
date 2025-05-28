import 'package:bloc/bloc.dart';
import 'package:stm_bloc/bloc/switch_example/switch_event.dart';
import 'package:stm_bloc/bloc/switch_example/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchState()) {
    on<EnableNotification>(_enableNotification);
    on<DisableNotification>(_disableNotification);
  }

  void _enableNotification(
    EnableNotification event,
    Emitter<SwitchState> emit,
  ) {
    emit(state.copyWith(isSwitched: true));
  }

  void _disableNotification(
    DisableNotification event,
    Emitter<SwitchState> emit,
  ) {
    emit(state.copyWith(isSwitched: false));
  }
}
