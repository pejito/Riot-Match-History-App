import 'package:riot_history_app/app/backend/high_elo_player.dart';

class HighEloLeaderboard{

  final String tier;
  final String name;
  final List<HighEloProfile> players;

  HighEloLeaderboard({
   required this.tier,
   required this.name,
   required this.players,
});

  factory HighEloLeaderboard.fromJson(Map<String, dynamic> json){
    var list = json['entries'] as List;
    List<HighEloProfile> highEloProfileList = list.map((i) => HighEloProfile.fromJson(i)).toList();
    return HighEloLeaderboard(
        tier: json['tier'],
        name: json['name'],
        players: highEloProfileList,
    );
  }


}