class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final int damage;
  final int attackPower;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    this.damage = 20,
    this.attackPower = 30,
  });
}
