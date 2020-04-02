import 'package:flutter/material.dart';
import 'package:track_corona/rootPage.dart';

void main() {
  return runApp(new TrackCorona());
}

class TrackCorona extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black
      ),
      title: 'Track Corona',
      home: RootPage(),
    );
  }
}

