import 'package:flutter/material.dart';
import 'package:volsungur_app/providers/notifications.dart';
import 'package:volsungur_app/widgets/app_drawer.dart';
import '../providers/channel_model.dart';
import '../providers/video_model.dart';
import './video_screen.dart';
import '../services/api_services.dart';
import 'package:provider/provider.dart';
import './notification_list.dart';
import '../widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Channel _channel;
  bool _isFetching = true;
  bool _isLoading = true;
  var _isInit = true;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isFetching = true;
      });
    }
    Provider.of<Notifications>(context, listen: false)
        .fetchTrainings()
        .then((_) {
      setState(() {
        _isFetching = false;
      });
    });
    _isInit = false;
    super.didChangeDependencies();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UC7fCGzb_ZlIHezeTKnmi-XA');
    setState(() {
      _channel = channel;
    });
  }

  _buildVideo(Video video) {
    return Container(
      height: 0,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoScreen(id: video.id),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
          padding: EdgeInsets.all(10.0),
          width: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            border: Border.all(width: 3, color: Colors.green),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Image(
                alignment: Alignment(-1, -1),
                width: 150,
                image: NetworkImage(video.thumbnailUrl),
              ),
              SizedBox(height: 10.0),
              Text(
                video.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    // _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(230, 32, 32, 32),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _channel != null
                  ? NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollDetails) {
                        if (!_isLoading &&
                            _channel.videos.length !=
                                int.parse(_channel.videoCount) &&
                            scrollDetails.metrics.pixels ==
                                scrollDetails.metrics.maxScrollExtent) {
                          _loadMoreVideos();
                        }
                        return false;
                      },
                      child: Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: _channel.videos.length,
                          itemBuilder: (BuildContext context, int index) {
                            Video video = _channel.videos[index];
                            return _buildVideo(video);
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor, // Red
                        ),
                      ),
                    ),
              Container(
                padding: EdgeInsets.all(10),
                height: 250,
                child: Image(
                    image: NetworkImage(
                        'https://www.volsungur.is/static/news/1584357344_volsungs-logo.jpg')),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 250,
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('Tilkynningar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ))),
                    SizedBox(height: 10),
                    NotificationList(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
