import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> openLocationLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }
}
