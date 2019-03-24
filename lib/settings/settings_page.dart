import 'package:flutter/material.dart';
import '../game/game.dart';
import '../purchase/purchase_logic.dart';
import 'pie_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SettingsPage extends StatefulWidget {
  final MyGame game;

  SettingsPage(this.game);

  @override
  SettingsPageState createState() => SettingsPageState(this.game);
}

class SettingsPageState extends State<SettingsPage> {
  final MyGame game;
  bool isAudioPlaying = true;

  SettingsPageState(this.game);

  void handleAudioToggle() {
    bool isPlaying = !this.isAudioPlaying;
    setState(() {
      this.isAudioPlaying = isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new DefaultTabController(
      length: settingsCategories.length,
      child: new Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new TabBar(
            tabs: settingsCategories.map((Category choice) {
              return new Tab(
                child: Text(
                  choice.name,
                  style: TextStyle(color: Colors.black),
                ),
                icon: new Icon(
                  choice.icon,
                  color: Colors.black,
                ),
              );
            }).toList(),
          ),
        ),
        body: new TabBarView(
          children: settingsCategories.map((Category choice) {
            return new Padding(
              padding: const EdgeInsets.all(0.0),
              child: _choiceWidget(choice),
            );
          }).toList(),
        ),
      ),
    ));
  }

  Widget _choiceWidget(Category choice) {
    if (choice.index == 1) {
      return _settingsWidget();
    } else {
      return new Column(children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 16.0),
            child: AutoSizeText("Follower Output", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                maxLines: 2,
            )
        ),
        _statsWidget()
      ]);
    }
  }

  Widget _statsWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: PieOutsideLabelChart.withFollowerData(this.game),
    );
  }

  Widget _settingsWidget() {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return _toggleSettingWidget();
                      } else {
                        return _saveAlterationWidget(this.game);
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleSettingWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16.0, left: 16.0, right: 16.0),
                      child: Text(
                        'Audio',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Toggle Background Music',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16.0)),
                          ),
                          GestureDetector(
                            child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: FloatingActionButton(
                                    child: Icon(
                                        this.isAudioPlaying
                                            ? Icons.volume_off
                                            : Icons.volume_up,
                                        color: Colors.white),
                                    backgroundColor: Colors.indigoAccent,
                                    onPressed: () => handleAudioToggle())),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _saveAlterationWidget(MyGame game) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    height: 250.0,
    child: Card(
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0, left: 16.0, right: 16.0),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, left: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('Save your progress',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 16.0)),
                        ),
                        GestureDetector(
                          child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: FloatingActionButton(
                                  child: Icon(Icons.save, color: Colors.white),
                                  backgroundColor: Colors.indigoAccent,
                                  onPressed: () => game.saveData())),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, left: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('Reset your progress',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 16.0)),
                        ),
                        GestureDetector(
                          child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: FloatingActionButton(
                                  child: Icon(Icons.delete_forever,
                                      color: Colors.white),
                                  backgroundColor: Colors.indigoAccent,
                                  onPressed: () => game.deleteSave())),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

List<Category> settingsCategories = [
  Category(name: 'Settings', icon: Icons.developer_mode, index: 1),
  Category(name: 'Statistics', icon: Icons.insert_chart, index: 2),
];
