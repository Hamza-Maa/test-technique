class Book {
  final String id;
  final String title;
  final String subtitle;
  final String authors;
  final String image;
  final String url;

  Book({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.authors,
    required this.image,
    required this.url,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'] ?? '',
        authors: json['authors'],
        image: json['image'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'authors': authors,
        'image': image,
        'url': url,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Book && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class BookResponse {
  final String status;
  final int total;
  final List<Book> books;

  BookResponse({
    required this.status,
    required this.total,
    required this.books,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) => BookResponse(
        status: json['status'],
        total: json['total'] is String
            ? int.tryParse(json['total']) ?? 0
            : json['total'],
        books:
            (json['books'] as List).map((book) => Book.fromJson(book)).toList(),
      );
}
