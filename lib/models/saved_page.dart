class SavedPage {
  final String bookName;
  final String pdfPath;
  final int pageNumber;
  final DateTime savedAt;

  SavedPage({
    required this.bookName,
    required this.pdfPath,
    required this.pageNumber,
    required this.savedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookName': bookName,
      'pdfPath': pdfPath,
      'pageNumber': pageNumber,
      'savedAt': savedAt.toIso8601String(),
    };
  }

  factory SavedPage.fromJson(Map<String, dynamic> json) {
    return SavedPage(
      bookName: json['bookName'],
      pdfPath: json['pdfPath'],
      pageNumber: json['pageNumber'],
      savedAt: DateTime.parse(json['savedAt']),
    );
  }
}




