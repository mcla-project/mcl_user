class FAQItem {
  final String question;
  final String answer;
  final int? id; // Optional field for database identity

  FAQItem({this.id, required this.question, required this.answer});

  // Method to create an FAQItem from a map (useful when fetching data from a database)
  factory FAQItem.fromMap(Map<String, dynamic> map) {
    return FAQItem(
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
    );
  }

  // Method to convert an FAQItem to a map (useful for sending data to a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }

  // Optional: Implement toString for easier debugging.
  @override
  String toString() {
    return 'FAQItem{id: $id, question: $question, answer: $answer}';
  }
}
