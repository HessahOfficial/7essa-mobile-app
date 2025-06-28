part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class ContactUsEvent extends ContactEvent {
  final ContactUsRequest request;

  ContactUsEvent({required this.request});
}
