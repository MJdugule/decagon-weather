import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract class DeviceLocation {
  Future<bool> requestPermission();
  Future<Position> getCurrentLocation();
}

@LazySingleton(as: DeviceLocation)
class DeviceLocationImpl implements DeviceLocation {
  @override
  Future<bool> requestPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
          
        return true;
      }
     
      return Future.error('Location permissions are denied');
    } else {
      
      return true;
    }
  }

  @override
  Future<Position> getCurrentLocation() async {
    await requestPermission();
    var position = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
