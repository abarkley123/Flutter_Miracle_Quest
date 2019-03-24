/// Simple pie chart with outside labels example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../game/game.dart';
import '../purchase/purchase_logic.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with follower data and no transition.
  factory PieOutsideLabelChart.withFollowerData(MyGame game) {
    return new PieOutsideLabelChart(
      _createFollowerData(game),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Add an [ArcLabelDecorator] configured to render labels outside of the
        // arc with a leader line.
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside),
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OutputModel, int>> _createFollowerData(MyGame game) {
    List<OutputModel> data = new List();
    for (int i = 0; i < game.followerPurchases.length; i++) {
      if (game.followerPurchases[i].amount > 0) {
        data.add(new OutputModel(game.followerPurchases[i].title, i, getCompleteOutputFrom(game.followerPurchases[i]).ceil()));
      }
    }

    return [
      new charts.Series<OutputModel, int>(
        id: 'Followers',
        domainFn: (OutputModel followers, _) => followers.purchaseNum,
        measureFn: (OutputModel followers, _) => followers.output,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (OutputModel row, _) => '${row.name}: ${row.output}',
      )
    ];
  }
}

class OutputModel {
  final String name;
  final int purchaseNum;
  final int output;

  OutputModel(this.name, this.purchaseNum, this.output);
}