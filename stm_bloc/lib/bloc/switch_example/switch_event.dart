import 'package:equatable/equatable.dart';

abstract class SwitchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EnableOrDisableNotification extends SwitchEvent {}

class SliderEvent extends SwitchEvent {
  final double sliderValue;
  SliderEvent({required this.sliderValue});

  @override
  List<Object?> get props => [sliderValue];
}
