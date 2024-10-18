import 'package:flutter/material.dart';
import '../models/album.dart';

class ReadingListProvider extends ChangeNotifier {
  final List<Album> _albums = [];

  List<Album> get albums => _albums;

  void addAlbumReadingList(Album album) {
    if (!_albums.contains(album)) {
      _albums.add(album);
      notifyListeners();
    }
  }

  void removeAlbumReadingList(Album album) {
    if (_albums.contains(album)) {
      _albums.remove(album);
      notifyListeners();
    }
  }

  bool isReadingList(Album album) {
    return _albums.contains(album);
  }
}
