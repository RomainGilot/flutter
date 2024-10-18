import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/album.dart';
import '../screens/album_details.dart';

class AlbumsMap extends StatelessWidget {
  const AlbumsMap({super.key, required this.title, required this.albums});
  final dynamic title;
  final List<Album> albums;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Lieux de Tintin'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(10, 12),
                initialZoom: 2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: albums.map((album) {
                    return Marker(
                      width: 400.0,
                      height: 200.0,
                      point: LatLng(album.gps.latitude, album.gps.longitude),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlbumDetails(
                                album: album,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.transparent,
                          child: const Icon(Icons.location_on, color: Colors.red),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
