class Profile {

  final String summonerName;
  final int summonerLevel;
  final String id;

  Profile({
    required this.summonerName,
    required this.summonerLevel,
    required this.id,
  });
  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(
      summonerName: json['name'],
      summonerLevel: json['summonerLevel'],
      id: json['id'],
    );
  }
}