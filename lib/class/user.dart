class User {
  int id;
  String name;
  int score;
  User({
    required this.id,
    required this.name,
    required this.score,
  });
}

var user = <User>[
  User(
    id: 1,
    name: 'teo',
    score: 400,
  ),
  User(
    id: 2,
    name: 'michael',
    score: 500,
  ),
];
