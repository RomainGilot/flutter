import 'package:hive/hive.dart';

part 'gps.g.dart';

@HiveType(typeId: 1)
class Gps {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  Gps({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() {
    return 'Gps(latitude: $latitude, longitude: $longitude)';
  }
}
