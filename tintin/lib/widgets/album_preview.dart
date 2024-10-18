import 'package:flutter/material.dart';
import '../models/album.dart';
import '../screens/album_details.dart';

class AlbumPreview extends StatelessWidget {
  final Album album;
  final bool isReadingList;
  final Function(Album) toggleReadingList;

  const AlbumPreview({
    super.key,
    required this.album,
    required this.isReadingList,
    required this.toggleReadingList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
            leading: album.image.isNotEmpty
                ? Image.network(
              album.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.image_not_supported, size: 50),
            title: Text(album.title, style: const TextStyle(color: Colors.black),),
            trailing: IconButton(
              icon: Icon(
                isReadingList ? Icons.playlist_add_check : Icons.playlist_add,
                color: isReadingList ? Colors.red : Colors.grey,
              ),
              onPressed: () => toggleReadingList(album),
            ),
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
          ),
        ),
      ),
    );
  }
}
