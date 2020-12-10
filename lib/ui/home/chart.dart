import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weatherApp/utils/colors.dart';
import '../common/common.dart';

class Chart extends StatelessWidget {
  Widget _buildChart() {
    var line1 = [
      FlSpot(-10, 14),
      FlSpot(-9, 18),
      FlSpot(-8, 16.7),
      FlSpot(-7, 13.8),
      FlSpot(-6, 13),
      FlSpot(-5, 14),
      FlSpot(-4, 18),
      FlSpot(-3, 16.7),
      FlSpot(-2, 13.8),
      FlSpot(-1, 13),
    ];
    var line2 = [
      FlSpot(-10, 15.6),
      FlSpot(-9, 15.8),
      FlSpot(-8, 14.5),
      FlSpot(-7, 13),
      FlSpot(-6, 11.5),
      FlSpot(-5, 13.4),
      FlSpot(-4, 15.1),
      FlSpot(-3, 13.4),
      FlSpot(-2, 14.2),
      FlSpot(-1, 11.6),
    ];
    var tmp = (line1 + line2).map<double>((e) => e.y);
    var minY = tmp.reduce(min) - 1;
    var maxY = tmp.reduce(max) + 1;
    return LineChart(LineChartData(
      lineBarsData: [
        _LineChart(SolarizedColorScheme.magenta, line1).getLine(),
        _LineChart(SolarizedColorScheme.red, line2).getLine(),
      ],
      maxY: maxY,
      minY: minY,
      gridData: FlGridData(drawHorizontalLine: false, drawVerticalLine: false),
      borderData: FlBorderData(
          border: Border(
              bottom:
                  BorderSide(width: 1, color: SolarizedColorScheme.accentFG))),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: SolarizedColorScheme.accentFG,
            fontSize: 12,
          ),
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: SolarizedColorScheme.accentFG,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 8,
          reservedSize: 30,
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: SolarizedColorScheme.mainBG,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            ThemedText(
                'Summary'.toUpperCase(), 18, SolarizedColorScheme.accentFG),
            SizedBox(
              height: 7,
            ),
            ThemedText('for several days'.toLowerCase(), 14,
                SolarizedColorScheme.mainFG),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(width: 700, child: _buildChart())),
          ],
        ));
  }
}

class _LineChart {
  final Color _color;
  final List<FlSpot> _spots;
  _LineChart(this._color, this._spots);

  LineChartBarData getLine() {
    return LineChartBarData(
      spots: _spots,
      isCurved: false,
      curveSmoothness: .0,
      colors: [
        _color,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
  }
}
