class ResultData {
  final int voteCount;
  final int id;
  final bool video;
  final String voteAverage;
  final String title;
  final String popularity;
  final String posterPath;
  final String originalLanguage;
  final String originalTitle;
  final String backdropPath;
  final bool adult;
  final String overview;
  final String releaseDate;

  ResultData(
      this.voteCount,
      this.id,
      this.video,
      this.voteAverage,
      this.title,
      this.popularity,
      this.posterPath,
      this.originalLanguage,
      this.originalTitle,
      this.backdropPath,
      this.adult,
      this.overview,
      this.releaseDate);

  ResultData.fromJson(Map<String, dynamic> json)
      : voteCount = json["vote_count"],
        id = json["id"],
        video = json["video"],
        voteAverage = json["vote_average"].toString(),
        title = json["title"],
        popularity = json["popularity"].toString(),
        posterPath = json["poster_path"],
        originalLanguage = json["original_language"],
        originalTitle = json["original_title"],
        backdropPath = json["backdrop_path"],
        adult = json["adut"],
        overview = json["overview"],
        releaseDate = json["release_date"];

}