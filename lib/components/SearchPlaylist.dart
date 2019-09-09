import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/state.model.dart';

class SearchPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Share your music taste with your friends!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          Container(
            height: 54,
            width: 300,
            margin: EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Flexible(
                  child: TextField(
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                onChanged: (String value) {
                  Provider.of<StateModel>(context, listen: false)
                      .updatePlaylistFilter(value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  hintText: "Search playlists",
                  filled: true,
                  fillColor: Color.fromARGB(255, 247, 249, 249),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 217, 224, 226), width: 1),
                  ),
                ),
              )),
              Container(
                width: 54,
                height: 35,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color.fromARGB(188, 0, 0, 0),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                child: Image.asset('assets/images/search.png'),
              )
            ]),
            decoration: BoxDecoration(
              color: Color.fromARGB(128, 0, 0, 0),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          )
        ],
      ),
    );
  }
}
