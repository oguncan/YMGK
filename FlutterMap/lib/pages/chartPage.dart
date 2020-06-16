import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartPage extends StatefulWidget {
  
  ChartPage({Key key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  // List<charts.Series<String, int>> series = [
  //   charts.Series(
  //     data: widget.matter,

  //   )
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grafik Ekranı"),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Text("Merhaba"),
    );
  }
}
