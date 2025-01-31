class BookDetails {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String authors;
  final String publisher;
  final String pages;
  final String year;
  final String image;
  final String url;
  final String download;

  BookDetails({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.authors,
    required this.publisher,
    required this.pages,
    required this.year,
    required this.image,
    required this.url,
    required this.download,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'authors': authors,
      'publisher': publisher,
      'pages': pages,
      'year': year,
      'image': image,
      'url': url,
      'download': download,
    };
  }

  factory BookDetails.fromJson(Map<String, dynamic> json) {
    return BookDetails(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      authors: json['authors'],
      publisher: json['publisher'] ?? '',
      pages: json['pages'] ?? '',
      year: json['year'] ?? '',
      image: json['image'],
      url: json['url'],
      download: json['download'] ?? '',
    );
  }
}
