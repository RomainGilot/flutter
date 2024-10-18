import 'package:hive/hive.dart';
import 'gps.dart';

part 'album.g.dart';

@HiveType(typeId: 0)
class Album {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final int numero;

  @HiveField(2)
  final int year;

  @HiveField(3)
  final int? yearInColor;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final String resume;

  @HiveField(6)
  final Gps gps;

  @HiveField(7)
  final String location;

  Album({
    required this.title,
    required this.numero,
    required this.year,
    this.yearInColor,
    required this.image,
    required this.resume,
    required this.gps,
    required this.location,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      title: json['titre'] as String,
      numero: json['numero'],
      yearInColor: json['parutionEnCouleur'],
      resume: json['resume'] as String,
      year: json['parution'],
      image: json['image'] as String,
      location: json['lieu'] as String,
      gps: Gps(
        latitude: double.parse(json['gps'].split(',')[0]),
        longitude: double.parse(json['gps'].split(',')[1]),
      ),
    );
  }
}
