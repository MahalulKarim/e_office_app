import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GPSController extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  final _isErrorGps = false.obs;
  bool get isErrorGps => _isErrorGps.value;
  set isErrorGps(bool value) => _isErrorGps.value = value;

  Future<Placemark> getAddressFromPosition(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks[0];
  }

  Future<Position?> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    loading = true;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      loading = false;
      isErrorGps = true;
      return null;
    }
    permission = await Geolocator.checkPermission();
    if (kIsWeb) {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // loading = false;
      // isErrorGps = false;
      // return null;
    } else {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          await Geolocator.openLocationSettings();
          loading = false;
          isErrorGps = true;
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          await Geolocator.openLocationSettings();
          loading = false;
          isErrorGps = true;
          return null;
        }
      }
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: kIsWeb ? LocationAccuracy.low : LocationAccuracy.best,
        timeLimit: const Duration(seconds: 30),
      );
      isErrorGps = false;
      if (position.latitude == 0 && position.longitude == 0) {
        loading = false;
        return null;
      }
      loading = false;
      return position;
    } catch (e) {
      loading = false;
      isErrorGps = true;
      return null;
    }
  }

  Future<bool> checkIsInOffice(Position? position) async {

    
    const storage = FlutterSecureStorage();
    var officeLatitude = await storage.read(key: 'office_latitude');
    var officeLongitude = await storage.read(key: 'office_longitude');
    var officeMaxDistance = await storage.read(key: 'office_max_distance');

    if (officeLatitude == null || officeLatitude == "") {
      return false;
    }

    if (position == null) {
      return false;
    }
    if (position.latitude == 0 && position.longitude == 0) {
      return false;
    }

    double distance = Geolocator.distanceBetween(
      double.parse(officeLatitude.toString()),
      double.parse(officeLongitude.toString()),
      position.latitude,
      position.longitude,
    );
    if (distance <= int.parse(officeMaxDistance.toString())) {
      return true;
    }
    return false;
  }
}
