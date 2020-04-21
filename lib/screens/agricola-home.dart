import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-data.dart';
import 'package:scoreboards_app/components/agricola-scores.dart';
import 'package:scoreboards_app/components/agricola-wins.dart';
import 'package:scoreboards_app/components/agricola-raw-data.dart';
import 'package:scoreboards_app/components/agricola-roundup.dart';

class Agricola extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AgricolaState();
  }
}

class _AgricolaState extends State<Agricola> {
  bool isLoading = true;
  int _currentIndex = 0;
  List<Widget> _chartPages = [];
  AgricolaData _agricolaData;

  void initialiseData() {
    loadGame().then((data) => setState(() {
          _agricolaData = AgricolaData(data);
          _chartPages = [
            AgricolaRoundup(agricolaData: _agricolaData),
            AgricolaWins(agricolaData: _agricolaData),
            AgricolaScores(agricolaData: _agricolaData)
          ];
          isLoading = false;
        }));
  }

  @override
  void initState() {
    this.initialiseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: this._currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            title: Text('Roundup'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            title: Text('Wins'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.multiline_chart),
            title: Text('Scores'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.group_work), title: Text('Categories'))
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: isLoading
              ? Text('Loading...')
              : this._chartPages[this._currentIndex],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
