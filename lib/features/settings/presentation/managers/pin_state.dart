part of 'pin_cubit.dart';

@immutable
abstract class PinState {}

class PinInitial extends PinState {}

class PinSuccess extends PinState {}

class PinFailure extends PinState {
  final String message;

  PinFailure({required this.message});
}
