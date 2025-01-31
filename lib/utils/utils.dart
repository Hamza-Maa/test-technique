String sanitizeBookId(String bookId) {
  return bookId.replaceAll(RegExp(r'[^0-9]'), '');
}
