class Book {
  final String id;
  final String title;
  final String authors;
  final String thumbnail;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.thumbnail,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    List<dynamic>? authors = json['volumeInfo']['authors'];
    var thumbnail = json['volumeInfo']['imageLinks']['thumbnail'];

    return Book(
      id: json['id'],
      title: json['volumeInfo']['title'],
      authors: authors != null ? authors.join(', ') : 'desconhecido',
      thumbnail: thumbnail,
    );
  }
}
