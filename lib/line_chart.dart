import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mood_shifting_assistent/utils/truncate_doubles.dart';

class LineChart extends StatefulWidget {

  final weeklyProgresses;

  const LineChart({ Key? key, this.weeklyProgresses }) : super(key: key);

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {

  // _LineDefaultState();
  bool isCardView = false;

  List<ChartData>? chartData;

  @override
  void initState() {
    chartData = <ChartData>[];

    for(int i = 0; i < widget.weeklyProgresses.length; i++) {
      chartData?.add(
        ChartData(
        i + 1, 
        TruncateDoubles().truncateToDecimalPlaces(widget.weeklyProgresses.elementAt(i), 2)  * 10, 
        50
      ),
      );
    }

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