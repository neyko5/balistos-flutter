import 'package:balistos/models/state.model.dart';
import '../models/playlist.model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'PlaylistItem.dart';

class PlaylistItems extends StatelessWidget {
  final List<Playlist> playlists;

  PlaylistItems(this.playlists);

  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(builder: (context, state, child) {
      return new Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: playlists
                .where((Playlist p) => p.title
                    .toLowerCase()
                    .startsWith(state.playlistFilter.toLowerCase()))
                .take(10)
                .map((Playlist playlist) {
              return new PlaylistItem(
                  playlist: playlist,
                  playlistIndex: playlists.indexOf(playlist) + 1);
            }).toList(),
          ));
    });
  }
}
