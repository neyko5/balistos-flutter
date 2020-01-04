import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Homepage
class PlaylistMain extends StatefulWidget {
  final playlist;
  final videos;
  PlaylistMain(this.playlist, this.videos);

  @override
  _PlaylistMainState createState() => _PlaylistMainState(playlist, videos);
}

class _PlaylistMainState extends State<PlaylistMain> {
  final playlist;
  final videos;
  YoutubePlayerController _controller;

  _PlaylistMainState(this.playlist, this.videos);

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        forceHideAnnotation: true,
        hideControls: true
      ),
    );
    super.initState();
  }

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
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
      ),
      RaisedButton(
        onPressed: () {
          _controller.load("sPKj-K6dWmo");
        },
        child: Text(
          "Google login",
          style: TextStyle(color: Colors.white),
        ),
      )
    ]);
  }
}
