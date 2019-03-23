import 'package:shared_preferences/shared_preferences.dart';
import '../purchase/purchase_logic.dart';
import 'dart:math';

void savePurchaseFor(String type, SharedPreferences prefs, List<CurrencyModel> purchases) {
  for (int i = 0; i < purchases.length; i++) {
    prefs.setInt(type + i.toString() + "Amount", purchases[i].amount);
    prefs.setDouble(type + i.toString() + "Cost", purchases[i].cost);
    prefs.setDouble(type + i.toString() + "Multiplier", purchases[i].multiplier);
  }
}

void loadPurchase(String type, SharedPreferences prefs, List<CurrencyModel> purchases) {
  for (int i = 0; i < purchases.length; i++) {
    purchases[i].amount = prefs.getInt(type + i.toString() + "Amount") ?? 0;
    purchases[i].cost = prefs.getDouble(type + i.toString() + "Cost") ?? purchases[i].cost;
    purchases[i].multiplier = prefs.getDouble(type + i.toString() + "Multiplier") ?? 1.0;
    if (purchases[i].amount < 1) {
      purchases[i].baseProd = purchases[i].startingProd;
    } else {
      purchases[i].baseProd = purchases[i].startingProd * (pow(1.05, purchases[i].amount));
    }
  }
}
