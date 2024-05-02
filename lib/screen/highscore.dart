import 'package:cardgame/class/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Highscore extends StatefulWidget {
  @override
  _HighscoreState createState() => _HighscoreState();
}

class _HighscoreState extends State<Highscore> {
  late Map<String, dynamic> _topScore;
  bool _checkPoint = true;

  @override
  void initState() {
    super.initState();
    _getTopScore().then((value) {
      setState(() {
        _topScore = value;
        _checkPoint = false;
      });
    });
  }

  Future<Map<String, dynamic>> _getTopScore() async {
    final prefs = await SharedPreferences.getInstance();
    final topUser = prefs.getString("top_user") ?? "";
    final topPoint = prefs.getInt("top_point") ?? 0;
    return {'top_user': topUser, 'top_point': topPoint};
  }

  @override
  Widget build(BuildContext context) {
    user.sort((a, b) => b.score.compareTo(a.score));
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Center(
        child: _checkPoint
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Top User: ${_topScore['top_user']}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Top Point: ${_topScore['top_point']}',
                    style: TextStyle(fontSize: 20),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: widRecipes(),
                  ),
                ],
              ),
      ),
    );
  }

  List<Widget> widRecipes() {
    List<Widget> temp = [];
    int i = 0;
    while (i < user.length) {
      int userID = user[i].id;

      Widget w = Card(
          child: Column(
        children: [
          Text(
            'Rank: ${i + 1}'
          ),
          Text(
            user[i].name,
            style: TextStyle(fontSize: 30),
          ),
          Text(
            user[i].score.toString(),
            textAlign: TextAlign.justify,
          )
        ],
      ));
      temp.add(w);
      i++;
    }
    return temp;
  }
}
