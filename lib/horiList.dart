import 'package:flutter/material.dart';
import 'package:music_app/playaudio.dart';

class HoriList extends StatefulWidget {
  final imgpath;
  final title;
  final url;
  final singer;
  HoriList(
      {@required this.imgpath,
      @required this.title,
      @required this.url,
      this.singer = " "});
  @override
  _HoriListState createState() => _HoriListState();
}

class _HoriListState extends State<HoriList> {
  @override
  void initState() {
    super.initState();
    short1();
    short2();
  }

  String Sname;
  String Tname;
  void short1() {
    if (widget.singer.length > 19) {
      Sname = widget.singer.substring(0, 19);
    } else {
      Sname = widget.singer;
    }
  }

  void short2() {
    if (widget.title.length > 17) {
      Tname = widget.title.substring(0, 14) + "..";
    } else {
      Tname = widget.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return YellowBird(
              imgPath: widget.imgpath,
              tit: widget.title,
              url: widget.url,
              singer: widget.singer,
            );
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF30314D),
        ),
        height: 170,
        width: 150,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.all(5),
                width: 85.0,
                height: 85.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      image: NetworkImage(widget.imgpath),
                    ))),
            SizedBox(
              height: 15,
            ),
            Text(
              "${Tname}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
