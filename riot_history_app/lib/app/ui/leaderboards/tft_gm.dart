import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:riot_history_app/app/backend/high_elo_player.dart';
import 'package:riot_history_app/app/backend/high_elo_player_leaderboard.dart';
import 'package:riot_history_app/app/services/auth.dart';

class GrandMastersLeaderboard extends StatefulWidget {
  @override
  _GrandMastersLeaderboardState createState() => _GrandMastersLeaderboardState();
}

class _GrandMastersLeaderboardState extends State<GrandMastersLeaderboard> {

  late List<HighEloProfile> _players;

  Future<HighEloLeaderboard> _fetchLeaderboard(String auth) async{
    final response = await http.get(Uri.parse('https://na1.api.riotgames.com/tft/league/v1/grandmaster?api_key=' + auth));
    if(response.statusCode == 200){
      print("gm leaderboard status code:" + response.statusCode.toString());
      return HighEloLeaderboard.fromJson(json.decode(response.body));
    }else{
      print(" Rank status code" + response.statusCode.toString());
      throw Exception('Failed to find player');
    }
  }

  void setPlayers(){
    setState((){
      _fetchLeaderboard(API.auth).then((HighEloLeaderboard leaderboard){
        _players = leaderboard.players;
        _players.sort((a, b) => a.lp.compareTo(b.lp));
        _players = _players.reversed.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String _auth = API.auth;
    setPlayers();
    return Scaffold(
      body: Center(
        child: FutureBuilder<HighEloLeaderboard>(
        future: _fetchLeaderboard(_auth),
        builder: (context, leaderboard){
          if(leaderboard.hasData){
            return Center(
              child: ListView.separated(
                  padding: const EdgeInsets.all(14),
                  itemCount: _players.length,
                  itemBuilder: (context, index){
                    return Container(
                      height: 70,
                      color: Colors.red[400],
                      child: ListTile(
                        leading: Image.asset('assests/grandmaster.png'),
                        title: Text(_players[index].summonerName, style: TextStyle(color: Colors.white70)),
                        subtitle: Text(_players[index].lp.toString() + " LP", style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    );
                  },
                separatorBuilder: (context, index){
                    return Divider();
                },
                  )
            );
              }else if (!leaderboard.hasData){
              return Column(children:
                  [CircularProgressIndicator(),
                  Text('Unable to find leaderboard right now.'),
                  ]
                );
              }
              return const CircularProgressIndicator();
          },
          ),
        )
    );
  }
}



