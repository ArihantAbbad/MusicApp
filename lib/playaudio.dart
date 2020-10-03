import 'package:chewie_audio/chewie_audio.dart';
import 'package:chewie_audio/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _chewieAudioController.dispose();
            //             _videoPlayerController2.pause();
            //             _videoPlayerController2.seekTo(Duration(seconds: 0));
            //             _chewieAudioController = ChewieAudioController(
            //               videoPlayerController: _videoPlayerController1,
            //               autoPlay: true,
            //               looping: true,
            //             );
            //           });
            //         },
            //         child: Padding(
            //           child: Text("Video 1"),
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _chewieAudioController.dispose();
            //             _videoPlayerController1.pause();
            //             _videoPlayerController1.seekTo(Duration(seconds: 0));
            //             _chewieAudioController = ChewieAudioController(
            //               videoPlayerController: _videoPlayerController2,
            //               autoPlay: true,
            //               looping: true,
            //             );
            //           });
            //         },
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //           child: Text("Error Video"),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _platform = TargetPlatform.android;
            //           });
            //         },
            //         child: Padding(
            //           child: Text("Android controls"),
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _platform = TargetPlatform.iOS;
            //           });
            //         },
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //           child: Text("iOS controls"),
            //         ),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
