import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../models/state.model.dart';
import '../components/AppBar.dart';
import '../components/SearchVideo.dart';
import '../components/ListVideos.dart';
import '../components/PlaylistMain.dart';
import '../components/Related.dart';
import '../components/Chat.dart';

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
                                            return ListVideos(
                                                videosSnapshot.data);
                                          case 2:
                                            return Chat();
                                          case 3:
                                            return Related();
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
