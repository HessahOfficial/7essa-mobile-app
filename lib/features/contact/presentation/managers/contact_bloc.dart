import 'package:bloc/bloc.dart';

import 'package:hessa/features/contact/data/models/contact_us_request.dart';
import 'package:hessa/features/contact/data/models/contact_us_response.dart';
import 'package:hessa/features/contact/data/repositories/contact_service.dart';
import 'package:meta/meta.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService service;

  ContactBloc({required this.service}) : super(ContactInitial()) {
    on<ContactUsEvent>((event, emit) async {
      final response = await service.contactUs(request: event.request);
      response.fold(
        (failure) {
          emit(ContactUsFailure(message: failure.message));
        },
        (data) {
          emit(ContactUsSuccess(response: data));
        },
      );
    });
  }
}
