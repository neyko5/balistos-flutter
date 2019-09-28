import 'package:balistos/components/PlaylistMain.dart';
import 'package:balistos/components/YoutubeResult.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:balistos/models/state.model.dart';
import 'package:youtube_api/youtube_api.dart';

import '../appBar.dart';

class DetailPage extends StatelessWidget {
  final String playlistId;

  DetailPage({Key key, @required this.playlistId}) : super(key: key);

  List<Widget> _children() => [
        SearchSection(this.playlistId),
        ListSection(),
        ChatSection(),
        RelatedSection(),
      ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = _children();
    return Scaffold(
      appBar: BalistosAppBar(),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Center(
            child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .document('playlists/${this.playlistId}')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return Column(
                      children: [
                        PlaylistMain(snapshot.data),
                        Consumer<StateModel>(
                          builder: (context, state, child) {
                            return children[state.currentTabIndex];
                          },
                        )
                      ],
                    );
                }
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Consumer<StateModel>(
        builder: (context, state, child) {
          return BottomNavigationBar(
            currentIndex: state.currentTabIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Color.fromARGB(255, 204, 204, 204),
            selectedIconTheme: IconThemeData(color: Colors.black),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: new Text('Search')),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  title: new Text('Videos')),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat,
                  ),
                  title: new Text('Chat')),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.group_work,
                  ),
                  title: new Text('Related'))
            ],
            onTap: (index) {
              state.setCurrentTabIndex(index);
            },
          );
        },
      ),
    );
  }
}

class SearchSection extends StatefulWidget {
  final String playlistId;
  SearchSection(this.playlistId);

  @override
  SearchSectionState createState() => SearchSectionState(this.playlistId);
}

class SearchSectionState extends State<SearchSection> {
  final String playlistId;
  SearchSectionState(this.playlistId);

  static String key = 'AIzaSyB-2hx-NqmEzBUNNLRKISUfLxylg2wEfzs';
  YoutubeAPI ytApi = new YoutubeAPI(key);
  List ytResult = [];

  void search(String query) async {
    var result = await ytApi.search(query);
    setState(() {
      ytResult = result;
    });
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
                  children:
                      ytResult.map((item) => YoutubeResult(item)).toList(),
                ),
                margin: EdgeInsets.only(top: 10))
          ],
        ));
  }
}

class ListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("List");
  }
}

class ChatSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Chat");
  }
}

class RelatedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Related");
  }
}
