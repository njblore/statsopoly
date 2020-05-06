import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-raw-data.dart';

import 'package:date_format/date_format.dart';
import 'package:scoreboards_app/helpers/dateFormat.dart';

class AgricolaScoreInput extends StatefulWidget {
  AgricolaScoreInput({Key key});

  @override
  _AgricolaScoreInputState createState() => _AgricolaScoreInputState();
}

class _AgricolaScoreInputState extends State<AgricolaScoreInput> {
  final _formKey = GlobalKey<FormState>();
  final GameScore formData =
      GameScore(datePlayed: null, locationPlayed: null, playerScores: null);
  final Map<int, PlayerScore> playerScores = {};

  var playerList = [];
  var index = 0;
  bool loading = false;
  var initalState = {
    'formData':
        GameScore(datePlayed: null, locationPlayed: null, playerScores: null),
    'playerList': [],
    'loading': false,
    'playerScores': {}
  };

  @override
  void initState() {
    super.initState();
    setState(() => initalState);
    addPlayerToList();
  }

  clearState() {
    _formKey.currentState.reset();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.lightGreen[100],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Enter Scores",
          style: Theme.of(context).primaryTextTheme.title,
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Stack(children: [
          Visibility(
            visible: loading,
            child: Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  backgroundColor: Colors.transparent,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.brown[800]),
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  maxWidth: viewportConstraints.maxWidth * 0.8,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.datetime,
                                  initialValue: formatDate(DateTime.now(),
                                      [dd, '-', mm, '-', yyyy]).toString(),
                                  decoration:
                                      InputDecoration(labelText: 'Date Played'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'When??';
                                    } else if (!RegExp(r"\d{2}-\d{2}-\d{4}")
                                        .hasMatch(value)) {
                                      return 'Date like: "DD-MM-YYY"';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (String value) {
                                    setState(() {
                                      formData.datePlayed =
                                          deserializeDatestring(value);
                                    });
                                  },
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.transparent,
                                width: 20,
                              ),
                              Flexible(
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  initialValue: "Manchester",
                                  decoration:
                                      InputDecoration(labelText: 'Location'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Where??';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    formData.locationPlayed = value;
                                  },
                                ),
                              )
                            ],
                          ),
                          ...playerList,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlatButton(
                                  onPressed: () => playerList.length >= 5
                                      ? null
                                      : addPlayerToList(),
                                  color: loading
                                      ? Colors.grey
                                      : Colors.yellow[300],
                                  child: Text('Add Player',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle),
                                ),
                                buildSubmitButton()
                              ]),
                        ]),
                      )
                    ]),
              ),
            ),
          ),
        ]);
      }),
    );
  }

  void _submitForm() {
    print('Submitting form');
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('Form was validated');
      setState(() {
        this.formData.playerScores = playerScores.values.toList();
      });
      postGameScore(formData).then((res) {
        if (res.statusCode == 200) {
          clearState();
        }
      });
    }
  }

  Future<http.Response> postGameScore(GameScore newGameScoreJson) async {
    setState(() {
      loading = true;
    });

    var fetchedScores = await _fetchGames();
    var fetchedScoresJson = jsonDecode(fetchedScores.body);

    List<GameScore> fetchedGameList =
        AllGames.fromJson(fetchedScoresJson).gameScores;

    fetchedGameList.add(newGameScoreJson);
    var updatedGameListJson = AllGames(gameScores: fetchedGameList).toJson();

    return http.put(
      "https://api.jsonbin.io/b/5ea01b9b2940c704e1dc9684/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'secret-key':
            '\$2b\$10\$tVk/rIX8TJ15Zm5Oghjz1.0zwMVyQyzIUggpp/cngra1xISpd9N/q'
      },
      body: jsonEncode(updatedGameListJson),
    );
  }

  Future<http.Response> _fetchGames() {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'secret-key':
          '\$2b\$10\$tVk/rIX8TJ15Zm5Oghjz1.0zwMVyQyzIUggpp/cngra1xISpd9N/q'
    };
    return http.get("https://api.jsonbin.io/b/5ea01b9b2940c704e1dc9684/latest",
        headers: requestHeaders);
  }

  buildSubmitButton() {
    return FlatButton(
      onPressed: () {
        playerList.length < 2 ? null : _submitForm();
      },
      color: loading
          ? Colors.grey
          : playerList.length < 2 ? Colors.grey : Colors.green[400],
      child: Text(loading ? "Sending Scores..." : "Submit",
          style: Theme.of(context).primaryTextTheme.subtitle),
    );
  }

  addPlayerToList() {
    setState(() {
      playerList.add(makePlayerFormSection(index));
      playerScores[index] = PlayerScore();
      index += 1;
    });
  }

  removePlayerForm(String key) {
    setState(() {
      this.playerList.retainWhere((player) => player.key != Key(key));
      this.playerScores.remove(num.parse(key));
    });
  }

  List<Color> colorList = [
    Colors.teal[300].withOpacity(0.5),
    Colors.pink[200].withOpacity(0.5),
    Colors.amber[300].withOpacity(0.5),
    Colors.purple[100].withOpacity(0.5),
    Colors.deepOrange[700].withOpacity(0.5),
  ];

  makePlayerFormSection(int index) {
    var totalValue = 0;
    return Padding(
      key: Key(index.toString()),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: colorList[index], borderRadius: BorderRadius.circular(4)),
        child: Column(children: <Widget>[
          Row(children: [
            Flexible(
              flex: 2,
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: 'Player Name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Who??';
                  }
                  return null;
                },
                onSaved: (String value) {
                  playerScores[index].playerName = value;
                },
              ),
            ),
            VerticalDivider(
              color: Colors.transparent,
              width: 20,
            ),
            makeCategoryInputField("Fields", index),
            VerticalDivider(
              color: Colors.transparent,
              width: 20,
            ),
            makeCategoryInputField("Pastures", index),
          ]),
          Row(
            children: <Widget>[
              makeCategoryInputField("Grain", index),
              VerticalDivider(
                color: Colors.transparent,
                width: 20,
              ),
              makeCategoryInputField("Vegetables", index),
              VerticalDivider(
                color: Colors.transparent,
                width: 20,
              ),
              makeCategoryInputField("Sheep", index),
              VerticalDivider(
                color: Colors.transparent,
                width: 20,
              ),
              makeCategoryInputField("Wild Boar", index),
            ],
          ),
          Row(
            children: <Widget>[
              makeCategoryInputField("Cattle", index),
              VerticalDivider(
                color: Colors.transparent,
                width: 20,
              ),
              makeCategoryInputField("Unused Spaces", index),
              VerticalDivider(
                color: Colors.transparent,
                width: 20,
              ),
              makeCategoryInputField("Fenced Stables", index),
              VerticalDivider(
                color: Colors.transparent,
                width: 20,
              ),
              makeCategoryInputField("Clay Rooms", index),
            ],
          ),
          Row(
            children: <Widget>[
              makeCategoryInputField("Stone Rooms", index),
              VerticalDivider(
                color: Colors.transparent,
                width: 20,
              ),
              makeCategoryInputField("Family Members", index),
              VerticalDivider(
                color: Colors.transparent,
                width: 20,
              ),
              makeCategoryInputField("Points for Cards", index),
              VerticalDivider(
                color: Colors.transparent,
                width: 20,
              ),
              makeCategoryInputField("Bonus Points", index)
            ],
          ),
          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                onPressed: () => this.playerList.length == 1
                    ? null
                    : removePlayerForm(index.toString()),
                icon: Icon(Icons.delete_forever),
                iconSize: 30,
                color: Colors.red,
                disabledColor: Colors.grey,
              ))
        ]),
      ),
    );
  }

  getTotal(int playerIndex) {
    var total = playerScores[playerIndex]
        .categoryScores
        .fold(0, (total, score) => score.categoryPoints += total);
    return total;
  }

  makeCategoryInputField(String category, int playerIndex) {
    return Flexible(
        child: TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: category,
          labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 10)),
      validator: (value) {
        if (num.parse(value).isNaN) {
          return 'Gonna need a number';
        }
        return null;
      },
      onSaved: (String value) {
        if (playerScores[playerIndex].categoryScores == null) {
          playerScores[playerIndex].categoryScores = [
            CategoryScore(categoryPoints: 0, categoryName: "total")
          ];
        }

        playerScores[playerIndex].categoryScores.add(CategoryScore(
            categoryName: category, categoryPoints: num.parse(value)));

        var currentTotal = playerScores[playerIndex]
            .categoryScores
            .firstWhere((category) => category.categoryName == "total")
            .categoryPoints;

        playerScores[playerIndex]
            .categoryScores
            .firstWhere((category) => category.categoryName == "total")
            .categoryPoints = currentTotal + num.parse(value);
      },
    ));
  }
}
