import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:music_app/playPage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = 'Welcome';
  @override
  _State createState() => _State();
}

class _State extends State<WelcomeScreen> {
  TextEditingController nameController = TextEditingController();
  bool _saving = false;
  String query;


  //@override
//  void initState() async {
//
//    super.initState();
//    var multisongURL = 'https://www.jiosaavn.com/api.php?__call=webradio.getSong&stationid=ViJK7H0SzH3DQw5AXAF7U3EeY-Mp6UMpKwzeMURwYi2cMHuO1wQB-A__&k=5&next=1&api_version=4&_format=json&_marker=0&ctx=wap6dot0';
//    try {
//      var response = await http.get(multisongURL);
//      if (response.statusCode == 200) {
//        var jsonResponse = jsonDecode(response.body);
//        for(var i=0;i<4;i++) {
//          var en_id = jsonResponse['$i']['song']['more_info']['encrypted_media_url'];
//
//          print('$en_id');
//          en_id = en_id.replaceAll('+', '%2B');
//          en_id = en_id.replaceAll('/', '%2F');
//          print('$en_id');
//          getNO(en_id);
//        }
//      } else {
//        print('Request failed with status: ${response.statusCode}.');
//      }
//    } catch (e) {
//      print(e);
//    }
//  }

  void getFinalUrl(no_id) async {
    setState(() {
      _saving = false;
      nameController.clear();
    });
    var finalURL =
        'https://sklktecdnems05.cdnsrv.jio.com/jiosaavn.cdn.jio.com/$no_id';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PlayAudio(
          imgPath: imgUrl,
          url: finalURL,
          title: titlee,
        );
      }),
    );
  }

  void getNO(en_id) async {
    var noURL =
        'https://www.jiosaavn.com/api.php?__call=song.generateAuthToken&url=$en_id&bitrate=128&api_version=4&_format=json&ctx=wap6dot0&_marker=0';
    try {
      var response = await http.get(noURL);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var no_id = jsonResponse['auth_url'];
        int ind = no_id.indexOf('?');
        no_id = no_id.substring(27, ind);

        print(no_id);
        getFinalUrl(no_id);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  void getID(token) async {
    var tokenURL =
        'https://www.jiosaavn.com/api.php?__call=webapi.get&token=$token&type=song&includeMetaTags=0&ctx=wap6dot0&api_version=4&_format=json&_marker=0';
    try {
      var response = await http.get(tokenURL);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var en_id =
            jsonResponse['songs'][0]['more_info']['encrypted_media_url'];

        print('$en_id');
        en_id = en_id.replaceAll('+', '%2B');
        en_id = en_id.replaceAll('/', '%2F');
        print('$en_id');
        getNO(en_id);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  String imgUrl;
  String titlee;

  void getToken() async {
    var queryURL =
        'https://www.jiosaavn.com/api.php?__call=autocomplete.get&query=$query&_format=json&_marker=0&ctx=wap6dot0';

    try {
      var response = await http.get(queryURL);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var image = jsonResponse['songs']['data'][0]['image'];
        image = image.replaceAll('50x50','500x500');
        imgUrl = image;
        var title = jsonResponse['songs']['data'][0]['title'];
        titlee = title;
        var fulltoken = jsonResponse['songs']['data'][0]['url'];
        int l = fulltoken.length;
        var token = fulltoken.substring(l - 11, l);
        print('token: $token');
        print('$image');
        print('$title');
        getID(token);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: Scaffold(
          backgroundColor: Color(0xFF4F4F4F),
          body: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      onChanged: (value) {
                        query = value;
                      },
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white70,
                        )),
                        hintText: 'Search',
                        prefixIcon:
                            Icon(Icons.search, color: Colors.white, size: 25),
                      ),
                    ), //textfield
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          _saving = true;
                        });

                        getToken();

                        //do 1st 2 steps
                      },
                      child: Container(
                        height: 40,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'SEARCH',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ), //gesturedetector
//                 GestureDetector(
                    // child:

                    SizedBox(height: 60),
                    // ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Image(
                        width: 400,
                        height: 400,
                        image: NetworkImage('https://www.blhsnews.com/wp-content/uploads/2018/11/apple-music-note-800x420.jpg'),
                      ),
                    ),

                    //SizedBox(height:10),
                  ],
                ),
              ))),
    );
  }
}
