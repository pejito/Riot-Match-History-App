import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riot_history_app/app/backend/inherited_state_widget.dart';
import 'package:http/http.dart' as http;
import 'package:riot_history_app/app/services/auth.dart';
import 'package:riot_history_app/app/backend/rank.dart';
import 'package:riot_history_app/app/backend/profile.dart';

class PlayerProfile extends StatefulWidget {
  @override
  _PlayerProfileState createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {

  var poroImages = [
    'assests/baronporo.jpg',
    'assests/fireporo.png',
    'assests/gamerporo.jpg',
    'assests/ghostporo.png',
    'assests/groupofporo.jpg',
    'assests/pirateporo.jpg',
    'assests/spaceporo.jpg',
    'assests/wizardporo.jpg',
  ];
  late Random rnd;

  Image _img() {
    int min = 0;
    int max = poroImages.length-1;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    String imageName  = poroImages[r].toString();
    return Image.asset(imageName);
  }

  Future<Profile> fetchPlayer(String auth, String summonerName) async {
    final response = await http.get(Uri.parse(
        'https://na1.api.riotgames.com/tft/summoner/v1/summoners/by-name/'+summonerName+'?api_key=' +
            auth));
    if (response.statusCode == 200) {
      print("profile status code" + response.statusCode.toString());
      return Profile.fromJson(jsonDecode(response.body));
    }
    else{
      print("Status code: " + response.statusCode.toString());
      throw Exception('Failed to find player');
    }
  }

  Future<Rank> fetchRank(String auth, String summonerName) async{
    Profile prof = await fetchPlayer(auth, summonerName);
    String summonerID = prof.id;
    final response = await http.get(Uri.parse('https://na1.api.riotgames.com/tft/league/v1/entries/by-summoner/'+summonerID+'?api_key=' + auth));
    if(response.statusCode == 200){
      print(" Rank status code" + response.statusCode.toString());
      return Rank.fromJson(json.decode(response.body));
    }else{
      print("Status code: " + response.statusCode.toString());
      throw Exception('Failed to find player');
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = StateInheritedWidget.of(context).summonerName;
    String auth = API.auth;
    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 75),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: _img().image,
                      fit: BoxFit.fill
                  ),
                ),
              ),
            ),
            Column(
              children: [
                FutureBuilder<Profile>(
                future: fetchPlayer(auth, name),
                builder: (context, player){
                  if(player.hasData){
                    return Center(
                      child: Column(
                          children: [Text('Summoner Name: ' + player.data!.summonerName, style: GoogleFonts.padauk(
                            textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],),
                          ),),
                            Text('Summoner Level: ' + player.data!.summonerLevel.toString(), style: GoogleFonts.padauk(
                              textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],),
                            ),),
                          ],
                    )
                  );
                  }else if (player.hasError){
                    return Text('Unable to find player! Please try again.');
                    }
                  return const CircularProgressIndicator();
                },
              ), FutureBuilder<Rank>(
                    future: fetchRank(auth, name),
                    builder: (context, rank){
                      print(rank);
                      if(rank.hasData){
                        double winRate = (rank.data!.wins/rank.data!.losses) * 100;
                        winRate = double.parse((winRate).toStringAsFixed(2));
                        return Center(
                          child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                      [Text(rank.data!.tier, style: GoogleFonts.padauk(
                                        textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],),
                                      ),),
                                      Text(' '),
                                      Text(rank.data!.rank, style: GoogleFonts.padauk(
                                        textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],),
                                      ),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    [Text(rank.data!.lp.toString(), style: GoogleFonts.padauk(
                                      textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],),
                                    ),),
                                      Text(' LP', style: GoogleFonts.padauk(
                                      textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],)))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    [Text(rank.data!.wins.toString(), style: GoogleFonts.padauk(
                                      textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],),
                                    ),),
                                      Text(' Wins', style: GoogleFonts.padauk(
                      textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],)))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    [Text(rank.data!.losses.toString(), style: GoogleFonts.padauk(
                                      textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],),
                                    ),),
                                      Text(' Losses', style: GoogleFonts.padauk(
                      textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],))
                                      )],
                                  ),Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    [Text(winRate.toString() + '% 1st place rate', style: GoogleFonts.padauk(
                            textStyle: TextStyle( fontSize: 20, color: Colors.lightBlue[300],))
                        ),
                                    ],
                                  ),
                                ],
                              ),
                        );
                      }else if (rank.hasError){
                        return Text('Unable to find player rank.');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
              ]
            )
          ],
        ),
      )
    );
  }
}
