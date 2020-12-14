import 'package:flutter/material.dart';

import 'package:weatherApp/utils/colors.dart';

import 'package:weatherApp/ui/home/entireScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: CityWeather()));
    // floatingActionButton: _buildButton());
  }
}
