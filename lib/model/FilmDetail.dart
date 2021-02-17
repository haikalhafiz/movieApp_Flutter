

class FilmDetail {
  final String imdbId;
  final String title;
  final String year;
  final String type;
  final String poster;
  final String actors;
  final String plot;


  FilmDetail(
      {this.imdbId, this.title, this.year, this.type, this.poster, this.actors, this.plot});

      factory FilmDetail.fromJson(Map<String, dynamic>json){
          return FilmDetail(

              imdbId: json["imdbID"],
              title: json["Title"],
              year: json["Year"],
              type: json["Type"],
              poster: json["Poster"],
              actors: json["Actors"],
              plot: json["Plot"]


          );
        }
      }


