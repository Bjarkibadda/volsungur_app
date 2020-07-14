import 'package:flutter/material.dart';
import 'package:volsungur_app/providers/practice_model.dart';
import '../providers/practice_model.dart';
import 'package:provider/provider.dart';
import '../screens/video_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PracticeItem extends StatelessWidget {
  final String practiceTitle;

  PracticeItem(this.practiceTitle);

  @override
  Widget build(BuildContext context) {
    String videoId;
    final data = Provider.of<Practice>(context, listen: false);
    videoId = YoutubePlayer.convertUrlToId(data.url);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              VideoScreen.routeName,
              arguments: videoId,
            );
          },
          child: Image.network(
              'https://img.youtube.com/vi/$videoId/hqdefault.jpg', //Image.network(
              //data.thumbnailUrl,
              fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          title: Text(practiceTitle),
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
                data.isFavorite ? Icons.done : Icons.radio_button_unchecked),
            color: Colors.green,
            onPressed: () {
              data.toggleFavoriteStatus();
              data.updateFavoriteStatus();
            },
          ),
        ),
      ),
    );
  }
}
