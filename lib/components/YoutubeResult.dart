import 'package:flutter/material.dart';

class YoutubeResult extends StatelessWidget {
  final item;

  const YoutubeResult(this.item);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {},
      child: Container(
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
                    image: NetworkImage(this.item.thumbnail['medium']['url']),
                    fit: BoxFit.cover),
              ),
            ),
            Flexible(
              child: Text(
                this.item.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
