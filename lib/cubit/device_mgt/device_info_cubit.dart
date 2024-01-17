import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'dart:developer' as developer;

part 'device_info_state.dart';

class DeviceInfoCubit extends Cubit<DeviceInfoState> {
  DeviceInfoCubit() : super(const DeviceInfoState());

  void init() {
    initPlatformState();
    initNetworkInfo();
    dateNow();
  }

  void dateNow() {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    var loginDate = date;
    emit(state.copyWith(date: loginDate));
  }

  Future<void> initNetworkInfo() async {
    String? wifiIPv4;
    final NetworkInfo networkInfo = NetworkInfo();

    try {
      if (!kIsWeb && Platform.isIOS) {
        // ignore: deprecated_member_use
        var status = await networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          // ignore: deprecated_member_use
          status = await networkInfo.requestLocationServiceAuthorization();
        }
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi Name', error: e);
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        // ignore: deprecated_member_use
        var status = await networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          // ignore: deprecated_member_use
          status = await networkInfo.requestLocationServiceAuthorization();
        }
      } else {}
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
    }

    try {
      wifiIPv4 = await networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv4', error: e);
      wifiIPv4 = 'Failed to get Wifi IPv4';
    }

    emit(state.copyWith(ipAddress: wifiIPv4));
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      deviceData = switch (defaultTargetPlatform) {
        TargetPlatform.android =>
          _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
        TargetPlatform.iOS =>
          _readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
        _ => <String, dynamic>{'Error:': 'Unsupported platform'},
      };
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    emit(state.copyWith(deviceData: deviceData));
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'brand': build.brand,
      'device': build.device,
      'version.baseOS': build.version.baseOS,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
    };
  }
}
