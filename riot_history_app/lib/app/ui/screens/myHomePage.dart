import 'package:flutter/material.dart';
import 'package:riot_history_app/app/ui/leaderboards/leaderboards.dart';
import 'package:riot_history_app/app/backend/inherited_state_widget.dart';
import 'player_profile.dart';

class MyHomePage extends StatefulWidget {
  final String value;
  MyHomePage({Key? key, required this.value}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  static List<Widget> _pages = <Widget>[
    PlayerLDRBoards(),
    PlayerProfile()
  ];
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riot Games Tracker'),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () {
          updateSummonerN(" ");
          Navigator.pop(context);
          },
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_sharp),
            label: 'Leaderboards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Summoner Profile',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  void updateSummonerN(String summonerN){
    final provider = StateInheritedWidget.of(context);
    provider.updateSummonerName(summonerN);
  }

}
