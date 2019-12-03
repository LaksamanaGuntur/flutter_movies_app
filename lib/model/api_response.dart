import 'result_data.dart';

class ApiResponse {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<ResultData> results;

  ApiResponse(this.page, this.totalResults, this.totalPages, this.results);

  ApiResponse.fromJson(Map<String, dynamic> json) :
        page = json["page"],
        totalResults = json["total_results"],
        totalPages = json["total_pages"],
        results = (json["results"] as List).map((i) => new ResultData.fromJson(i)).toList();

  ApiResponse.withError(String errorValue) :
        page = 0,
        totalResults = 0,
        totalPages = 0,
        results = List();
}
