import 'package:flutter/material.dart';
import 'package:weatherApp/utils/colors.dart';

import 'city.dart';

class HomePage extends StatelessWidget {
  Widget _buildAppBar() {
    return AppBar(
        backgroundColor: SolarizedColorScheme.secondaryBG,
        title: const Text(
          "Asuka Weather App",
          style: TextStyle(fontSize: 18, color: SolarizedColorScheme.mainFG),
        ));
  }

  Widget _buildButton() {
    return FloatingActionButton(
        backgroundColor: SolarizedColorScheme.secondaryBG,
        child: const Icon(Icons.add, color: SolarizedColorScheme.mainFG),
        onPressed: () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: CityWeather()));
    // floatingActionButton: _buildButton());
  }
}
