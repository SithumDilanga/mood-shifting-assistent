import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  const LineChart({ Key? key }) : super(key: key);

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {

  // _LineDefaultState();
  bool isCardView = false;

  List<_ChartData>? chartData;

  @override
  void initState() {
    chartData = <_ChartData>[
      _ChartData(1, 21, 28),
      _ChartData(2, 24, 44),
      _ChartData(3, 36, 48),
      _ChartData(4, 38, 50),
      _ChartData(5, 54, 66),
      _ChartData(6, 57, 78),
      _ChartData(7, 70, 84)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mood vatiation'
          ),
        ),
        body: _buildDefaultLineChart()
      ),
    );
  }

  /// Get the cartesian chart with default line series
  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: isCardView ? '' : 'This week your mood variation'),
      legend: Legend(
          isVisible: isCardView ? false : true,
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
        animationDuration: 2500,
        dataSource: chartData!,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
        name: 'Germany',
        markerSettings: const MarkerSettings(isVisible: true)
      ),
      // LineSeries<_ChartData, num>(
      //     animationDuration: 2500,
      //     dataSource: chartData!,
      //     width: 2,
      //     name: 'England',
      //     xValueMapper: (_ChartData sales, _) => sales.x,
      //     yValueMapper: (_ChartData sales, _) => sales.y2,
      //     markerSettings: const MarkerSettings(isVisible: true)
      // )
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }

  // @override
  //   Widget build(BuildContext context) {
  //       final List<SalesData> chartData = [
  //           SalesData(DateTime(2010), 35),
  //           SalesData(DateTime(2011), 28),
  //           SalesData(DateTime(2012), 34),
  //           SalesData(DateTime(2013), 32),
  //           SalesData(DateTime(2014), 40)
  //       ];
 
  //       return Scaffold(
  //           body: Center(
  //               child: Container(
  //                   child: SfCartesianChart(
  //                       primaryXAxis: DateTimeAxis(),
  //                       series: <ChartSeries>[
  //                           // Renders line chart
  //                           LineSeries<SalesData, DateTime>(
  //                               dataSource: chartData,
  //                               xValueMapper: (SalesData sales, _) => sales.year,
  //                               yValueMapper: (SalesData sales, _) => sales.sales
  //                           )
  //                       ]
  //                   )
  //               )
  //           )
  //       );
  //   }
}
 
// class SalesData {
//   SalesData(this.year, this.sales);
//   final DateTime year;
//   final double sales;
// }

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}