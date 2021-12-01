class HighEloProfile {

  final String summonerName;
  final int lp;
  final int firstPlaces;
  final int bottomSevens;


  HighEloProfile({
    required this.summonerName,
    required this.lp,
    required this.firstPlaces,
    required this.bottomSevens,
  });

  factory HighEloProfile.fromJson(Map<String, dynamic> json){
    return HighEloProfile(
        summonerName: json['summonerName'],
        lp: json['leaguePoints'],
        firstPlaces: json['wins'],
        bottomSevens: json['losses']
    );
  }
}