import 'package:shared_preferences/shared_preferences.dart';
import '../purchase/purchase_logic.dart';

void savePurchaseFor(String type, SharedPreferences prefs, List<CurrencyModel> purchases) {
  for (int i = 0; i < purchases.length; i++) {
    prefs.setInt(type + i.toString() + "Amount", purchases[i].amount);
  }
}
