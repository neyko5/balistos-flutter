import 'package:balistos/components/PlaylistMain.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:balistos/models/state.model.dart';
import 'package:youtube_api/youtube_api.dart';

import '../appBar.dart';

class DetailPage extends StatelessWidget {
  final String playlistId;

  DetailPage({Key key, @required this.playlistId}) : super(key: key);

  final List<Widget> _children = [
    SearchSection(),
    ListSection(),
    ChatSection(),
    RelatedSection(),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                            return _children[state.currentTabIndex];
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
  @override
  SearchSectionState createState() => SearchSectionState();
}

class SearchSectionState extends State<SearchSection> {
  static String key = 'AIzaSyB-2hx-NqmEzBUNNLRKISUfLxylg2wEfzs';
  YoutubeAPI ytApi = new YoutubeAPI(key);
  List ytResult = [];

  void search() async {
    String query = "Flutter";
    var result = await ytApi.search(query);
    setState(() {
      ytResult = result;
    });
    print(ytResult);
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        RaisedButton(
          child: Text("Search"),
          onPressed: () {
            search();
          },
        ),
        ...ytResult
            .map(
              (a) => Column(
                children: [
                  Text(a.title),
                  Image.network(a.thumbnail['medium']['url'])
                ],
              ),
            )
            .toList()
      ],
    );
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
