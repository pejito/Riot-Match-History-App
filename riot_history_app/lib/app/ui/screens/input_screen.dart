import 'package:flutter/material.dart';
import 'package:riot_history_app/app/backend/inherited_state_widget.dart';
import 'package:riot_history_app/app/ui/screens/myHomePage.dart';
import 'package:google_fonts/google_fonts.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();

}

class _InputScreenState extends State<InputScreen> {
  var _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          children: <Widget> [
            Container(
              child: Column(
                children: [
                  new Text(
                    "Find you or your friend's rank in Riot's autochess game, Teamfight Tactics!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.padauk(
                      textStyle: TextStyle( fontSize: 50, color: Colors.lightBlue[300],),
                  ),
                  ),
                  new Icon(Icons.person_search_rounded,
                    size: 30,
                    color: Colors.white,
                  )
                ],
              ),
            ),

            new ListTile(title: new TextField(
              controller: _textController,
            ),
            ),
            new ListTile(
              title: new ElevatedButton(onPressed: (){
                updateSummonerN(_textController.text);
                var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new MyHomePage(
                        value: _textController.text),
                );
                Navigator.of(context).push(route);
              },
                  child: new Text("Search for Summoner"))
            ),
            Text("""TFT Buddy was created under Riot Games' "Legal Jibber Jabber" policy using assets owned by Riot Games.""",
              textAlign: TextAlign.center,
              style: TextStyle( fontSize: 9, color: Colors.black),
            ),
            Text("""Riot Games does not endorse or sponsor this project.""",
              textAlign: TextAlign.center,
              style: TextStyle( fontSize: 9, color: Colors.black),
            ),
          ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  void updateSummonerN(String summonerN){
    final provider = StateInheritedWidget.of(context);
    provider.updateSummonerName(summonerN);
  }

}
