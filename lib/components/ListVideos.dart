import 'package:flutter/material.dart';
import './VideoItem.dart';

class ListVideos extends StatelessWidget {
  final videos;
  ListVideos(this.videos);

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
