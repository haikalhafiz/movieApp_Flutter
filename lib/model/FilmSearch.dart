class FilmSearch {
  final String imdbId;
  final String title;
  final String year;
  final String type;
  final String poster;

  FilmSearch({this.imdbId, this.title, this.year, this.poster, this.type});


  factory FilmSearch.fromJson(Map<String, dynamic>json){
    return FilmSearch(

      imdbId: json["imdbID"],
      title: json["Title"],
      year: json["Year"],
      type: json["Type"],
      poster: json["Poster"],

    );
  }

  //transformation method

  static List<FilmSearch> filmsFromJson(dynamic json) {

    var searchResult = json["Search"];

    if (searchResult != null) {
      var results = new List<FilmSearch>();
      searchResult.forEach((v) {

        results.add(FilmSearch.fromJson(v));
      });
      return results;
    }
    return List<FilmSearch>();
  }
}