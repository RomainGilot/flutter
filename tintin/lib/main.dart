import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/reading_list_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/albums_master.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ReadingListProvider(),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tintin',
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: const AlbumsMaster(title: 'Albums'),
    );
  }
}
