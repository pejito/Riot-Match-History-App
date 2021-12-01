import 'package:flutter/material.dart';
import 'package:riot_history_app/app/ui/leaderboards/tft_challenger.dart';
import 'package:riot_history_app/app/ui/leaderboards/tft_gm.dart';
import 'package:riot_history_app/app/ui/leaderboards/tft_masters.dart';

class PlayerLDRBoards extends StatefulWidget {
  @override
  _PlayerLDRBoardsState createState() => _PlayerLDRBoardsState();
}

class _PlayerLDRBoardsState extends State<PlayerLDRBoards> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Masters',
                  ),
                  Tab(
                    text: 'Grandmaster',
                  ),
                  Tab(
                    text: 'Challenger',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MastersLeader(),
            GrandMastersLeaderboard(),
            ChallengerLeaderboard(),
          ],
        ),
      ),
    );
  }
}

