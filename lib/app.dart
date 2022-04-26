import 'package:flutter/material.dart';
import 'package:test_client_vtc/view/search_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Multiclient test',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(109, 234, 255, 1),
        colorScheme: ColorScheme.light(
          secondary: Color.fromRGBO(72, 74, 126, 1),
        ),
      ),
      home: const SearchPage(),
    );
  }
}