class Book {
  final String id;
  final String title;
  final String authors;
  final String thumbnail;
  final String description;
  final String? maturityRating;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.thumbnail,
    required this.description,
    this.maturityRating,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    List<dynamic>? authors = json['volumeInfo']['authors'];
    var imageLinks = json['volumeInfo']['imageLinks'];
    var thumbnail = imageLinks != null
        ? (imageLinks['large'] ??
            imageLinks['medium'] ??
            imageLinks['thumbnail'])
        : 'https://via.placeholder.com/300x450';
    var maturityRating = json['volumeInfo']['maturityRating'];

    var mapMaturity = {
      'NOT_MATURE': 'Livre',
      'MATURE': 'Adulto',
    };

    return Book(
      id: json['id'],
      title: json['volumeInfo']['title'],
      authors: authors != null ? authors.join(', ') : 'Desconhecido',
      thumbnail: thumbnail,
      description:
          json['volumeInfo']['description'] ?? 'Sem descrição disponível',
      maturityRating: mapMaturity[maturityRating] ?? 'Não informado',
    );
  }
}
