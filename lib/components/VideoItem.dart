import 'package:flutter/material.dart';

class VideoItem extends StatelessWidget {
  final item;
  const VideoItem(this.item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 54,
      color: Color.fromARGB(255, 232, 232, 232),
      margin: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://img.youtube.com/vi/${this.item['youtube_id']}/0.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Flexible(
            child: Text(
              this.item['title'],
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
