import 'package:flutter/material.dart';
import 'package:volsungur_app/providers/practice_model.dart';
import '../providers/practice_model.dart';
import 'package:provider/provider.dart';
import '../screens/video_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../providers/auth.dart';

class PracticeItem extends StatelessWidget {
  final String practiceTitle;

  PracticeItem(this.practiceTitle);

  @override
  Widget build(BuildContext context) {
    String videoId;
    final data = Provider.of<Practice>(context);
    final authData = Provider.of<Auth>(context);
    videoId = YoutubePlayer.convertUrlToId(data.url);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      shadowColor: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                VideoScreen.routeName,
                arguments: VideoScreen(id: videoId, title: practiceTitle)
              );
            },
            child:FadeInImage.assetNetwork(
              placeholder: 'assets/logo.png',
              image: 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
                 //Image.network(

                //data.thumbnailUrl,
            ),
          ),
          footer: GridTileBar(
              title: Text(practiceTitle),
              backgroundColor: Colors.black87,
              leading: IconButton(
                icon: Icon(
                    data.isDone ? Icons.done : Icons.radio_button_unchecked),
                color: Colors.green,
                onPressed: () {
                  data.toggleDoneStatus();
                  data.updateDoneStatus(authData.token, authData.userId);
                },
              ),
              trailing: IconButton(
                icon: Icon(
                  data.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Colors.green,
                onPressed: () {
                  data.toggleFavoriteStatus();
                  data.updateFavoriteStatus(authData.token, authData.userId);
                },
              )),
        ),
      ),
    );
  }
}
