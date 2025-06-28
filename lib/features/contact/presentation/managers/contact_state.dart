part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactUsLoading extends ContactState {}

class ContactUsSuccess extends ContactState {
  final ContactUsResponse response;

  ContactUsSuccess({required this.response});
}

class ContactUsFailure extends ContactState {
  final String message;

  ContactUsFailure({required this.message});
}
