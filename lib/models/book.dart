class Book {
  final String id;
  final String title;
  final String authors;
  final String thumbnail;
  final String description;
  final String? maturityRating;
  int? rating;
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.thumbnail,
    required this.description,
    this.maturityRating,
    this.rating,
    this.isFavorite = false,
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
      rating: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'authors': authors,
      'thumbnail': thumbnail,
      'description': description,
      'maturityRating': maturityRating,
      'rating': rating,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      authors: map['authors'],
      thumbnail: map['thumbnail'],
      description: map['description'],
      maturityRating: map['maturityRating'],
      rating: map['rating'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
