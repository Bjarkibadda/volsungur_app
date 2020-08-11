import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = '/video_screen';
  final String id;

  VideoScreen({this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = YoutubePlayerController(
  //     initialVideoId: ModalRoute.of(context).settings.arguments,
  //     flags: YoutubePlayerFlags(
  //       mute: false,
  //       autoPlay: true,
  //     ),
  //   );
  //   super.initState();
  // }

  String initialVideo() {
    if (widget.id == null) {
      return ModalRoute.of(context).settings.arguments;
    }
    else{
      return widget.id;
    }
    
  }

  void didChangeDependencies() {
    // Navigator.of(context).pop();
    _controller = YoutubePlayerController(
      initialVideoId: initialVideo(),
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Æfing')),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          print('Player is ready.');
        },
      ),
    );
  }
}
