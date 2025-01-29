import 'package:flutter/material.dart';

class BookItem extends StatefulWidget {
  final String imageUrl;
  final String author;
  final String title;
  final String? subtitle;
  final bool isFavorite;

  const BookItem({
    super.key,
    required this.imageUrl,
    required this.author,
    required this.title,
    this.subtitle,
    this.isFavorite = false,
  });

  @override
  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Image
              Image.asset(
                widget.imageUrl,
                width: 80,
                height: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              // Book Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Author
                    Text(
                      widget.author,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Title
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Subtitle (if available)
                    if (widget.subtitle != null)
                      Text(
                        widget.subtitle!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
              // Favorite Icon
              GestureDetector(
                onTap: _toggleFavorite,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Icon(
                    _isFavorite
                        ? Icons.bookmark_outlined
                        : Icons.bookmark_outline,
                    color: _isFavorite ? Colors.white : Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 80,
            endIndent: 0,
            height: 0,
          ),
        ],
      ),
    );
  }
}
