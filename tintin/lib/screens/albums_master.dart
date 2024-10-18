import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tintin/screens/albums_map.dart';
import '../models/album.dart';
import '../services/album_service.dart';
import '../providers/reading_list_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/album_preview.dart';

class AlbumsMaster extends StatelessWidget {
  const AlbumsMaster({super.key, required this.title});

  final dynamic title;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
              color: Colors.white,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),

        ],
      ),
      body: FutureBuilder<List<Album>>(
        future: AlbumService.fetchAlbums(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur a eu lieu'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final album = snapshot.data![index];
                final readingListProvider = Provider.of<ReadingListProvider>(context);
                return AlbumPreview(
                  album: album,
                  isReadingList: readingListProvider.isReadingList(album),
                  toggleReadingList: (Album album) {
                    if (readingListProvider.isReadingList(album)) {
                      readingListProvider.removeAlbumReadingList(album);
                    } else {
                      readingListProvider.addAlbumReadingList(album);
                    }
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Chargement en cours...'));
          }
        },
      ),
      floatingActionButton: FutureBuilder<List<Album>>(
        future: AlbumService.fetchAlbums(),
        builder: (context, snapshot) {
         if (snapshot.hasError) {
            return const FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.error),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final albums = snapshot.data!;
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlbumsMap(
                      title: 'Lieux de Tintin',
                      albums: albums,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.navigation),
            );
          } else {
            return const FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.block),
            );
          }
        },
      ),

    );
  }
}
