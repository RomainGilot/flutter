import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/album.dart';

class ReadingListProvider extends ChangeNotifier {
  late Box _readingListBox;
  final List<Album> _albums = [];

  ReadingListProvider() {
    _readingListBox = Hive.box('readingList');
    _loadReadingList();
  }

  List<Album> get albums => _albums;

  void _loadReadingList() {
    final List<dynamic> storedAlbums = _readingListBox.get('albums', defaultValue: []);
    _albums.addAll(storedAlbums.cast<Album>());
  }

  void addAlbumReadingList(Album album) {
    if (!_albums.any((a) => a.numero == album.numero)) {
      _albums.add(album);
      _saveToDatabase();
      notifyListeners();
    }
  }

  void removeAlbumReadingList(Album album) {
    if (_albums.any((a) => a.numero == album.numero)) {
      _albums.removeWhere((a) => a.numero == album.numero);
      _saveToDatabase();
      notifyListeners();
    }
  }

  bool isReadingList(Album album) {
    return _albums.any((a) => a.numero == album.numero);
  }

  void _saveToDatabase() {
    _readingListBox.put('albums', _albums);
  }
}
