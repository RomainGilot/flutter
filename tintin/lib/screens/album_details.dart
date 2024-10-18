import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../models/album.dart';
import '../providers/reading_list_provider.dart';

class AlbumDetails extends StatelessWidget {
  final Album album;

  const AlbumDetails({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    final readingListProvider = Provider.of<ReadingListProvider>(context);
    var isReadingList = readingListProvider.isReadingList(album);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(album.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        if (isReadingList) {
                          readingListProvider.removeAlbumReadingList(album);
                        } else {
                          readingListProvider.addAlbumReadingList(album);
                        }
                      },
                      icon: Icon(
                        isReadingList ? Icons.playlist_add_check : Icons.playlist_add,
                        color: isReadingList ? Colors.red : Colors.blue,
                      ),
                      label: Text(
                        isReadingList ? 'Supprimer de la liste' : 'Ajouter à la liste',
                        style: TextStyle(
                          color: isReadingList ? Colors.red : Colors.blue,
                        ),
                      ),

                    ),
                      album.image.isNotEmpty ? Image.asset(
                        album.image,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ) : const Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      album.title,
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text(
                      'Album n°${album.numero}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    Text(album.resume),
                    const SizedBox(height: 20),
                    Text('Année de parution : ${album.year}'),
                    const SizedBox(height: 20),

                    SizedBox(
                      height: 300,
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(album.gps.latitude, album.gps.longitude),
                          initialZoom: 2,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 400.0,
                                height: 200.0,
                                point: LatLng(album.gps.latitude, album.gps.longitude),
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
