import 'package:chewie_audio/chewie_audio.dart';
import 'package:chewie_audio/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class ChewieAudioDemo extends StatefulWidget {
  ChewieAudioDemo(
      {this.title = 'Chewie Audio Demo', this.url, this.imgPath, this.tit});

  final String title;
  final String url;
  final String imgPath;
  final String tit;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieAudioDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieAudioController _chewieAudioController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network('${widget.url}');
    _videoPlayerController2 = VideoPlayerController.network('${widget.url}');
    _chewieAudioController = ChewieAudioController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieAudioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData.light().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    "${widget.imgPath}",
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                child: Text(widget.tit),
              ),
            ),
            Center(
              child: ChewieAudio(
                controller: _chewieAudioController,
              ),
            ),
            RaisedButton(
              color: Colors.cyan,
              child: Text("Download Song!"),
              onPressed: () async {
                final status = await Permission.storage.request();

                if (status.isGranted) {
                  final externalDir = await getExternalStorageDirectory();

                  final id = await FlutterDownloader.enqueue(
                    url: widget.url,
                    savedDir: externalDir.path,
                    fileName: widget.tit + ".mp4",
                    showNotification: true,
                    openFileFromNotification: true,
                  );
                  if (id != null) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(
                          seconds: 3,
                          milliseconds: 500,
                        ),
                        content: Text(
                          "Download Completed\nFile saved at android/data/com.eduapp",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        backgroundColor: Colors.teal[100],
                      ),
                    );
                  }
                } else {
                  print("hello");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
