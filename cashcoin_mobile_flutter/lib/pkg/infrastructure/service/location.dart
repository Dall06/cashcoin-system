import 'package:geocoding/geocoding.dart' as gc;
import 'package:location/location.dart';

class LocationService {
  late double lat;
  late double lon;
  late String country;
  late String locality;
  late String admArea;

  getCoords() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  getPlacemark(LocationData l) async {
    double lat = 0.0;
    double lon = 0.0;
    if(l.latitude == null || l.longitude == null) {
      return null;
    }
    lat = l.latitude!;
    lon = l.longitude!;
    List<gc.Placemark> placemarks = await gc.placemarkFromCoordinates(lat, lon);
    return placemarks[0];
  }

  getLocation() async {
    final LocationData? c = await getCoords();
    if(c == null) {
      return null;
    }
    final gc.Placemark? p = await getPlacemark(c);
    if(p == null) {
      return null;
    }
    lat = c.latitude!;
    lon = c.longitude!;
    country = p.country!;
    locality = p.locality!;
    admArea = p.administrativeArea!;

    return true;
  }
}