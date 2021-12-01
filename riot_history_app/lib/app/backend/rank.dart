class Rank{
  final String tier;
  final String rank;
  final int lp;
  final int wins;
  final int losses;

  Rank({
    required this.tier,
    required this.rank,
    required this.lp,
    required this.wins,
    required this.losses,
  });

  factory Rank.fromJson(List<dynamic> json){
    Map<String, dynamic> values = json[0];
    print(values.toString());
    return Rank(
      tier: values['tier'],
      rank: values['rank'],
      lp: values['leaguePoints'],
      wins: values['wins'],
      losses: values['losses'],
    );
  }
}