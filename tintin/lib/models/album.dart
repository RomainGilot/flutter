import 'gps.dart';

class Album {
  final String title;
  final int numero;
  final int year;
  final int? yearInColor;
  final String image;
  final String resume;
  final Gps gps;
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

  @override
  String toString() {
    return 'Album(title: $title, numero: $numero, year: $year, yearInColor: $yearInColor, image: $image, resume: $resume, gps: $gps, location: $location)';
  }


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
