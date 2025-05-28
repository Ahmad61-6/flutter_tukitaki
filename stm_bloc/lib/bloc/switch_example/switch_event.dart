import 'package:equatable/equatable.dart';

abstract class SwitchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EnableNotification extends SwitchEvent {}

class DisableNotification extends SwitchEvent {}
