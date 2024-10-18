class Gps {
  final double latitude;
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
