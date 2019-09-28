import 'package:balistos/components/PlaylistMain.dart';
import 'package:balistos/components/VideoItem.dart';
import 'package:balistos/components/YoutubeResult.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:balistos/models/state.model.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../appBar.dart';

class DetailPage extends StatefulWidget {
  final String playlistId;

  DetailPage({this.playlistId});

  DetailPageState createState() => DetailPageState(playlistId: this.playlistId);
}

class DetailPageState extends State<DetailPage> {
  final String playlistId;

  DetailPageState({Key key, @required this.playlistId});
  ScrollController scrollController;
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BalistosAppBar(),
      body: SingleChildScrollView(
        controller: scrollController,
        child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Center(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .document('playlists/${this.playlistId}')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> playlistSnapshot) {
                    if (playlistSnapshot.hasError)
                      return new Text('Error: ${playlistSnapshot.error}');
                    switch (playlistSnapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('playlists/${this.playlistId}/videos')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> videosSnapshot) {
                            if (videosSnapshot.hasError)
                              return new Text('Error: ${videosSnapshot.error}');
                            switch (videosSnapshot.connectionState) {
                              case ConnectionState.waiting:
                                return new Text('Loading...');
                              default:
                                return Column(
                                  children: [
                                    PlaylistMain(
                                        playlistSnapshot.data, videosSnapshot),
                                    Consumer<StateModel>(
                                      builder: (context, state, child) {
                                        switch (state.currentTabIndex) {
                                          case 0:
                                            return SearchSection(
                                                this.playlistId,
                                                this.scrollController);
                                          case 1:
                                            return ListSection(
                                                videosSnapshot.data);
                                          case 2:
                                            return ChatSection();
                                          case 3:
                                            return RelatedSection();
                                          default:
                                            return SearchSection(
                                                this.playlistId,
                                                this.scrollController);
                                        }
                                      },
                                    )
                                  ],
                                );
                            }
                          },
                        );
                    }
                  }),
            )),
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

class ListSection extends StatelessWidget {
  final videos;
  ListSection(this.videos);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: videos.documents
            .map<Widget>((video) => new VideoItem(video.data))
            .toList(),
      ),
    );
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
