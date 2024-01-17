part of 'device_info_cubit.dart';

class DeviceInfoState extends Equatable {
  final String? date;
  final String? ipAddress;
  final Map<String, dynamic>? deviceData;
  const DeviceInfoState({
    this.date,
    this.ipAddress,
    this.deviceData,
  });

  @override
  List<Object?> get props => [
        date,
        ipAddress,
        deviceData,
      ];

  DeviceInfoState copyWith({
    String? date,
    String? ipAddress,
    Map<String, dynamic>? deviceData,
  }) {
    return DeviceInfoState(
      date: date ?? this.date,
      ipAddress: ipAddress ?? this.ipAddress,
      deviceData: deviceData ?? this.deviceData,
    );
  }
}
