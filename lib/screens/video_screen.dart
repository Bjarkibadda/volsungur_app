import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = '/video_screen';
  final String id;
  final String title;
  final String information;

  VideoScreen({this.id, this.title, this.information});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;



  String initialVideo() {
    final VideoScreen args = ModalRoute.of(context).settings.arguments;
    if (widget.id == null) {
      return args.id;
    } else {
      return widget.id;
    }
  }

  void didChangeDependencies() {
    // Navigator.of(context).pop();
    _controller = YoutubePlayerController(
      initialVideoId: initialVideo(),
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
      ),
    );
    final VideoScreen arg = ModalRoute.of(context).settings.arguments;
  }

  void launchYoutube(url) async {
    if (await canLaunch(url)) {
      final bool openYoutubeApp = await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        universalLinksOnly: true,
      );
    } else {
      await launch(url, forceSafariVC: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final VideoScreen arg = ModalRoute.of(context).settings.arguments;
    //final String id = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
    final String _youtubeLink = 'https://youtube.com/watch?v=${arg.id}';
    return Scaffold(
      appBar: AppBar(title: Text('Æfing')),
      body: Container(
        color: Colors.black,
        //height: _screenSize.height / 2,
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready.');
            },
          ),
          builder: (context, player) {
            return Stack(
              children: <Widget>[
                Container(height: _screenSize.height, width: _screenSize.width),
                player,
                Positioned(
                  top: 160,
                  right: -20,
                  child: Container(
                    //alignment: Alignment(1.0, 1.0),
                    child: FlatButton(
                      onPressed: () {
                        launchYoutube(_youtubeLink);
                      },
                      child: Container(
                        height: 90,
                        width: 90,
                        child: Image.network(
                            'https://www.freepnglogos.com/uploads/youtube-logo-red-hd-13.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Positioned(
                    top: 270,
                    left: 20,
                    child: Container(
                      padding: EdgeInsets.only(top:15, left:15, right:10),
                      height: 300,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: Column(
                        children: <Widget>[
                          Text(arg.title, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                          SizedBox(height:20),
                          Container(
                            alignment: Alignment.topLeft,
                            width: _screenSize.width - 70,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  
                                  arg.information,
                                  style: TextStyle(color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
