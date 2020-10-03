import 'package:flutter/material.dart';
import 'playaudio.dart';

class PlayAudio extends StatefulWidget {
  final String url;
  final String imgPath;
  final String title;
  PlayAudio({@required this.url, @required this.imgPath, this.title});
  @override
  _PlayAudioState createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChewieAudioDemo(
                  url: widget.url,
                  imgPath: widget.imgPath,
                  tit: widget.title,
                );
              }));
            },
            child: Text("play"),
          ),
        ],
      ),
    );
  }
}
