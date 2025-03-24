import 'package:flutter/material.dart';
import 'package:tic_tac_toe/views/dashboard_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Center(
            child: Text(
              'Tic Tac Toe',
              style: TextStyle(color: Colors.blueAccent, fontSize: 26),
            ),
          ),
        ),
        body: DashboardView(),
      ),
    );
  }
}