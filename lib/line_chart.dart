import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  const LineChart({ Key? key }) : super(key: key);

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {

  // _LineDefaultState();
  bool isCardView = false;

  List<ChartData>? chartData;

  @override
  void initState() {
    chartData = <ChartData>[
      ChartData(1, 4.5, 28),
      ChartData(2, 2.4, 44),
      ChartData(3, 5.6, 48),
      ChartData(4, 6.0, 50),
      ChartData(5, 5.5, 66),
      ChartData(6, 7.2, 78),
      ChartData(7, 3.8, 84)
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
      title: ChartTitle(text: isCardView ? '' : 'This week your mood variation(day vs mood)'),
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
  List<LineSeries<ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<ChartData, num>>[
      LineSeries<ChartData, num>(
        animationDuration: 2500,
        dataSource: chartData!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        width: 2,
        name: 'Mood',
        markerSettings: const MarkerSettings(isVisible: true)
      ),
      // LineSeries<ChartData, num>(
      //     animationDuration: 2500,
      //     dataSource: chartData!,
      //     width: 2,
      //     name: 'England',
      //     xValueMapper: (ChartData sales, _) => sales.x,
      //     yValueMapper: (ChartData sales, _) => sales.y2,
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