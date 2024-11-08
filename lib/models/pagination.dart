class Pagination {
  int currentPage;
  int totalPages;
  int totalResults;
  int pagesize;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalResults,
    required this.pagesize,
  });

  factory Pagination.fromJson(dynamic json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalResults: json['totalResults'],
      pagesize: json['pageSize'],
    );
  }
}
