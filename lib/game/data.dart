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
  CurrencyModel(1, 0, 1, "Articles ", "Spread your word in the town."),
  CurrencyModel(4, 0, 5, "Loudspeaker", "Make your voice heard from afar."),
  CurrencyModel(40, 0, 20, "Apostles", "Disciples to preach your holiness."),
  CurrencyModel(350, 0, 100, "Communion", "Strengthen bonds with your followers."),
];

List<CurrencyModel> energyPurchasesBaseline = [
  CurrencyModel(1, 0, 1, "Booth", "Slowly convert followers to energy."),
  CurrencyModel(10, 0, 5, "Intern", "An intern converts on your behalf."),
  CurrencyModel(50, 0, 20, "Shrine", "An entire shrine for conversion."),
  CurrencyModel(500, 0, 100, "Temple", "Convert hundreds for your needs."),
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
  UpgradeDescription("Velvet interior", "Make your Booth more premium, retrieved from a local charity shop."),
  UpgradeDescription("Brazilian Coffee", "Improve your Intern's productivity."),
  UpgradeDescription("Gilded Furniture", "Allow your followers more luxury."),
  UpgradeDescription("Holy Scripture", "Your word is spread more easily."),
];

List<UpgradeDescription> followerUpgradeDescriptions = [
  UpgradeDescription("New Writer ", "Articles published are higher quality."),
  UpgradeDescription("Bigger Amp", "Your speaker is heard by more people."),
  UpgradeDescription("Divine Robes", "The apostles now emanate mystic energy."),
  UpgradeDescription("Fine Chianti", "People gravitate towards your service, now excellently paired with fava beans."),
];
