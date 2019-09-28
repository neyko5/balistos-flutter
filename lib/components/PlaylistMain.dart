import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';

class PlaylistMain extends StatelessWidget {
  final playlist;
  final videos;

  PlaylistMain(this.playlist, this.videos);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        playlist.data['title'],
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      YoutubePlayer(
        context: context,
        autoPlay: true,
        source: "JaPwLN5-21o",
        quality: YoutubeQuality.LOW,
        onVideoEnded: () => {
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Video finished"),
          ))
        },
        // callbackController is (optional).
        // use it to control player on your own.
      ),
    ]);
  }
}
