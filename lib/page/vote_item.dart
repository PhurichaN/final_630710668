class VoteItem {
  final int id;
  final String team;
  final String group;
  final String image;
  final int countvote;

  VoteItem({
    required this.id,
    required this.team,
    required this.group,
    required this.image,
    required this.countvote,
  });

  factory VoteItem.fromJson(Map<String, dynamic> json) {
    return VoteItem(
      id: json['id'],
      team: json['team'],
      group: json['group'],
      image: json['flagImage'],
      countvote: json['voteCount'],
    );
  }
}