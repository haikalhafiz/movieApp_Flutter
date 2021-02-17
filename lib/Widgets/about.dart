import 'package:flutter/material.dart';


class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("About Us",style: TextStyle(color: Colors.red))),backgroundColor: Colors.black,),
      body:Column(
        children: [
          Image.asset("assets/harrypot.jpg"),
          Text("About Us"),
        ],
      ),
    );
  }
}
