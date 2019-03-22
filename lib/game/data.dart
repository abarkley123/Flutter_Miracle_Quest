import '../purchase/purchase_logic.dart';
import 'upgrade.dart';

void setupPurchases(List<CurrencyModel> energyPurchases,
    List<CurrencyModel> followerPurchases) {
  energyPurchases.addAll(energyPurchasesBaseline);
  followerPurchases.addAll(followerPurchasesBaseline);
}

void setupPurchaseUpgrades(
    List<EnergyUpgrade> energyUpgrades, List<FollowerUpgrade> followerUpgrades) {
  energyUpgrades.addAll(energyUpgradesBaseline);
  followerUpgrades.addAll(followerUpgradesBaseline);
}

List<CurrencyModel> followerPurchasesBaseline = [
  CurrencyModel(1, 0, 1, "Articles ", "1"),
  CurrencyModel(4, 0, 5, "Loudspeaker", "2"),
  CurrencyModel(40, 0, 20, "Apostles", "3"),
  CurrencyModel(350, 0, 100, "Communion", "4"),
];

List<CurrencyModel> energyPurchasesBaseline = [
  CurrencyModel(1, 0, 1, "Newspaper", "1"),
  CurrencyModel(10, 0, 5, "Intern", "2"),
  CurrencyModel(50, 0, 20, "Shrine", "3"),
  CurrencyModel(500, 0, 100, "Temple", "4"),
];

List<EnergyUpgrade> energyUpgradesBaseline = [
  EnergyUpgrade(100, 0, 1.5),
  EnergyUpgrade(2500, 0, 1.5),
  EnergyUpgrade(50000, 0, 1.5),
  EnergyUpgrade(1000000, 0, 1.5),
];

List<FollowerUpgrade> followerUpgradesBaseline = [
  FollowerUpgrade(100, 0, 1.5),
  FollowerUpgrade(2000, 0, 1.5),
  FollowerUpgrade(30000, 0, 1.5),
  FollowerUpgrade(750000, 0, 1.5),
];

List<UpgradeDescription> purchaseUpgradeDescriptions = [
  UpgradeDescription("Laminated pages ", "Make your Newspaper more premium."),
  UpgradeDescription("Brazilian Coffee", "Improve your Intern's productivity."),
  UpgradeDescription("Gilded Furniture", "Allow your followers more luxury."),
  UpgradeDescription("Holy Scripture", "Your word is spread more easily."),
];

List<UpgradeDescription> followerUpgradeDescriptions = [
  UpgradeDescription("New Writer ", "Articles published are higher quality."),
  UpgradeDescription("Bigger Amp", "Your speaker is heard by more people."),
  UpgradeDescription("Divine Robes", "The apostles now emanate mystic energy."),
  UpgradeDescription("Fine Chianti", "Spread the reach of communion."),
];
