import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tintin/models/album.dart';
import 'package:tintin/models/gps.dart';
import 'package:tintin/screens/albums_master.dart';
import 'providers/reading_list_provider.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(GpsAdapter());
  await Hive.openBox('readingList');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReadingListProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp(
        title: 'Albums de Tintin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AlbumsMaster(title: 'Albums de Tintin'),
      ),
    ),
  );
}
