

import 'package:flutter/material.dart';
import 'package:movieapp/Widgets/detail.dart';
import 'package:movieapp/model/FilmSearch.dart';
import 'about.dart';
import 'package:http/http.dart'as http; //default address
import 'dart:convert'; //default address



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FilmSearch> filmsearch = []; //declare variable FilmSearch => filmsearch
  var searchText = TextEditingController(); //get movie searched from textfield rather than hardcoding Harry Potter

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
          appBar: AppBar(title: Center(child: Text("HAIKAL FLIX",style: TextStyle(color: Colors.red),)), backgroundColor: Colors.black, actions: [
            IconButton(icon: Icon(Icons.info), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));
            }),
          ],),
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: TextField( controller: searchText,
                      decoration: InputDecoration(hintText: "Enter movie to search"),)),
                    FlatButton(onPressed: (){
                      if (searchText.text == ""){
                        print("error");
                      }
                      else {
                        FocusManager.instance.primaryFocus.unfocus();
                        fetchFilmSearchResult(searchText.text).then((value) =>
                        {

                          setState(() =>
                          {
                            filmsearch = value
                          })
                        });
                      }
                    }, child: Text("Search movie"))
                  ],
                ),
               Expanded(
                 //update listview
                 child: ListView.builder(itemCount: filmsearch.length,itemBuilder: (BuildContext context,int index){
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ListTile(
                     title: Text(filmsearch[index].title),
                     subtitle: Text("${filmsearch[index].type} - ${filmsearch[index].year}"),
                     leading: Image.network(filmsearch[index].poster),
                     trailing: Icon(Icons.keyboard_arrow_right),
                     onTap: (){
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context)=>DetailPage(info: filmsearch[index].imdbId,)));
                           }
                         )
                        );
                       }),
                     )
                   ],
                  ),
               ),

             ),
          );
       }
    }
          Future<List<FilmSearch>> fetchFilmSearchResult(searchText) async {
            final response = await http.get(
                'https://www.omdbapi.com/?s=$searchText&apikey=a5a5e86');

            if (response.statusCode == 200) {
              // If the server did return a 200 OK response,
              // then parse the JSON.


              return FilmSearch.filmsFromJson(jsonDecode(response.body));
            } else {
              // If the server did not return a 200 OK response,
              // then throw an exception.
              print("error");
              throw Exception('Failed to load film');
            }
          }
