class QuoteModel {
  final String id;
  final String content;
  final String author;
  final String category;
  final String? imageUrl;

  QuoteModel({
    required this.id,
    required this.content,
    required this.author,
    required this.category,
    this.imageUrl,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['_id'] ?? '',
      content: json['content'] ?? '',
      author: json['author'] ?? 'Unknown',
      category: (json['tags'] != null && json['tags'].isNotEmpty)
          ? json['tags'][0]
          : 'Inspiration',
      imageUrl: null, // optional future enhancement
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'author': author,
      'category': category,
    };
  }
}
