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

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      authors: json['authors'],
      image: json['image'],
      url: json['url'],
    );
  }
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

  factory BookResponse.fromJson(Map<String, dynamic> json) {
    var booksList = json['books'] as List;
    List<Book> books = booksList.map((book) => Book.fromJson(book)).toList();

    return BookResponse(
      status: json['status'],
      total: json['total'],
      books: books,
    );
  }
}
