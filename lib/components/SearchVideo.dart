import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './YoutubeResult.dart';

class SearchSection extends StatefulWidget {
  final String playlistId;
  final ScrollController scrollController;
  SearchSection(this.playlistId, this.scrollController);

  @override
  SearchSectionState createState() =>
      SearchSectionState(this.playlistId, this.scrollController);
}

class SearchSectionState extends State<SearchSection> {
  final String playlistId;
  final ScrollController scrollController;
  SearchSectionState(this.playlistId, this.scrollController);

  static String key = DotEnv().env['YOUTUBE_API_KEY'];

  YoutubeAPI ytApi = new YoutubeAPI(key, type: "video");
  List ytResult = [];

  void search(String query) async {
    var result = await ytApi.search(query);
    setState(() {
      ytResult = result;
    });
    this.scrollController.animateTo(260,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.black),
              onChanged: (String value) {
                if (value.length > 2) {
                  this.search(value);
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                hintText: "Search videos",
                filled: true,
                fillColor: Color.fromARGB(255, 247, 249, 249),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 217, 224, 226), width: 1),
                ),
              ),
            ),
            Container(
                child: Column(
                  children: ytResult
                      .map((item) => YoutubeResult(item, this.playlistId))
                      .toList(),
                ),
                margin: EdgeInsets.only(top: 10))
          ],
        ));
  }
}
