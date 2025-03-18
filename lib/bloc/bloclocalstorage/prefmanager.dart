import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class PrefManager {
  static setToken(var token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static setLat(var latitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('latitude', latitude);
  }

  static getLat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('latitude');
  }

  static setLocality(var locality) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locality', locality);
  }

  static getLocality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('locality');
  }

  static setNationality(var nationality) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nationality', nationality);
  }

  static getNationality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nationality');
  }

  static setAdditionalInfo(var additionalinfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nationaliadditionalinfoty', additionalinfo);
  }

  static getAdditionalInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nationaliadditionalinfoty');
  }

  static setName(var studentName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('studentName', studentName);
  }

  static getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('studentName');
  }

  static setClassId(var stuClassId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('StuClassId', stuClassId);
  }

  static getClassId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('StuClassId');
  }

  static Future<void> setCapturePosition(Position capturePosition) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert the Position object to a JSON string
    String positionJson = jsonEncode({
      'latitude': capturePosition.latitude,
      'longitude': capturePosition.longitude,
      'accuracy': capturePosition.accuracy,
      'altitude': capturePosition.altitude,
      'speed': capturePosition.speed,
      'speedAccuracy': capturePosition.speedAccuracy,
      'heading': capturePosition.heading,
      'timestamp': capturePosition.timestamp.toIso8601String(),
    });
    await prefs.setString('captureposition', positionJson);
  }

  static Future<Position?> getCapturePosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? positionJson = prefs.getString('captureposition');

    if (positionJson != null) {
      // Parse the JSON string and recreate the Position object
      Map<String, dynamic> positionMap = jsonDecode(positionJson);
      return Position(
        latitude: positionMap['latitude'],
        longitude: positionMap['longitude'],
        accuracy: positionMap['accuracy'],
        altitude: positionMap['altitude'],
        speed: positionMap['speed'],
        speedAccuracy: positionMap['speedAccuracy'],
        heading: positionMap['heading'],
        timestamp: positionMap['timestamp'] != null
            ? DateTime.parse(positionMap['timestamp'])
            : DateTime(1970, 1, 1),
        altitudeAccuracy: 77,
        headingAccuracy: 99, // Provide a default value for null
      );
    }
    return null;
  }

  static Position? captureposition;
  static setLon(var latitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('longitude', latitude);
  }

  static getLon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('longitude');
  }

  static setIsLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  static getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLoggedIn') != null) {
      return prefs.getBool('isLoggedIn');
    } else {
      return false;
    }
  }

  static setIsCountryBasedLocation(bool isCountryBasedLocation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCountryBasedLocation', isCountryBasedLocation);
  }

  static getIsCountryBasedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isCountryBasedLocation') != null) {
      return prefs.getBool('isCountryBasedLocation');
    } else {
      return false;
    }
  }

  static setUserSelectedCountry(var userselectedcountry) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userselectedcountry', userselectedcountry);
  }

  static getUserSelectedCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userselectedcountry');
  }

  static setCstate(String cState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cState', cState);
  }

  static Future<String?> getCstate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cState');
  }

  static setClang(String cLang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cLang', cLang);
  }

  static Future<String?> getClang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cLang');
  }

  static clearToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  static savePromoCode(String? refrelCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('refrelCode', refrelCode!);
  }

  static Future<String?> getReferelCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refrelCode') ?? "";
  }
}
