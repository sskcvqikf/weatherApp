import 'dart:math';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weatherApp/utils/colors.dart';
import 'package:weatherApp/bloc/forecastBloc.dart';
import '../common/common.dart';

class Chart extends StatelessWidget {
  final _forecastBloc = BlocProvider.getBloc<ForecastBloc>();
  List<FlSpot> temp = [FlSpot(1.0, 1.0)];
  List<FlSpot> feel = [FlSpot(1.0, 1.0)];

  Widget _buildChart() {
    return StreamBuilder(
        stream: _forecastBloc.forecastStream,
        builder: (_, AsyncSnapshot<List<Map<String, double>>> snaphot) {
          if (snaphot.hasData) {
            temp = List<FlSpot>();
            feel = List<FlSpot>();
            int currHours = DateTime.now().hour;
            snaphot.data.asMap().forEach((key, value) {
              temp.add(FlSpot(key.toDouble() + currHours, value['temp']));
              feel.add(FlSpot(key.toDouble() + currHours, value['feels']));
            });
          }
          var minY = 0.0;
          var maxY = 0.0;
          if (!(temp.isEmpty && feel.isEmpty)) {
            var tmp = (temp + feel).map<double>((e) => e.y);
            minY = tmp.reduce(min) - 1;
            maxY = tmp.reduce(max) + 3;
          }

          return LineChart(LineChartData(
            lineBarsData: [
              _LineChart(SolarizedColorScheme.magenta, temp).getLine(),
              _LineChart(SolarizedColorScheme.red, feel).getLine(),
            ],
            maxY: maxY,
            minY: minY,
            gridData:
                FlGridData(drawHorizontalLine: false, drawVerticalLine: false),
            borderData: FlBorderData(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: SolarizedColorScheme.accentFG))),
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTextStyles: (value) => const TextStyle(
                        color: SolarizedColorScheme.accentFG,
                        fontSize: 12,
                      ),
                  margin: 10,
                  getTitles: (value) {
                    if (value < 10) {
                      return "0${value.toInt()}:00";
                    } else if (value > 24) {
                      return "0${value.toInt() % 24}:00";
                    } else {
                      return "${value.toInt()}:00";
                    }
                  }),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 15,
        ),
        ThemedText('Forecast'.toUpperCase(), 18, SolarizedColorScheme.accentFG),
        SizedBox(
          height: 7,
        ),
        ThemedText(
            'for next 12 hours'.toLowerCase(), 14, SolarizedColorScheme.mainFG),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ThemedText("ACTUAL", 12, SolarizedColorScheme.magenta,
              weight: FontWeight.w700),
          SizedBox(width: 10),
          ThemedText("FEELS", 12, SolarizedColorScheme.red,
              weight: FontWeight.w700)
        ]))),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
                width: 1000,
                padding: EdgeInsets.all(20),
                child: _buildChart())),
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
