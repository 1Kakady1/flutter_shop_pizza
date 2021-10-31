import 'package:geolocator/geolocator.dart';

class LocationHelper {
  late double latitude;
  late double longitude;
  String error = "";
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await this._determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
      error = "";
    } catch (e) {
      error = 'Something goes wrong: $e';
      print('Something goes wrong: $e');
    }
  }
}
