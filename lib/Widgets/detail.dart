import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapp/model/FilmDetail.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {

  final String info;

  DetailPage({this.info});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  FilmDetail filmdetail; //assign var FilmDetail => filmdetail

  @override
  void initState() {
    super.initState();
    fetchDetailFromId(widget.info).then((value) =>
    {

      setState(() {
        filmdetail = value;
      })
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("Movie Detail"))),
        body:
        filmdetail != null ?
        SingleChildScrollView(
          child: Column(
            children: [
              Image.network(filmdetail.poster),
              Text(filmdetail.title),
              SizedBox(height: 10,),
              Text(filmdetail.year),
              SizedBox(height: 10,),
              Text(filmdetail.actors),
              SizedBox(height: 10,),
              Text(filmdetail.plot)
            ],
          ),
         )
            :
            CircularProgressIndicator()
       );
      }
     }


      Future<FilmDetail> fetchDetailFromId(imdbId) async {
        final response = await http.get(
            'https://www.omdbapi.com/?i=$imdbId&apikey=a5a5e86');

        if (response.statusCode == 200) {
          print(response.body);
          // If the server did return a 200 OK response,
          // then parse the JSON.
          return FilmDetail.fromJson(jsonDecode(response.body));

        } else {
          // If the server did not return a 200 OK response,

          // then throw an exception.
          throw Exception('Failed to load film');
        }
      }

