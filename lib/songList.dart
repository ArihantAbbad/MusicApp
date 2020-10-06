import 'package:http/http.dart' as http;
import 'dart:convert';

class SongList {
  List Final_List_URL = [];
  Future<List> getFinalUrl(no_id) async {
    for (int i = 0; i < no_id.length; i++) {
      var finalURL =
          'https://sklktecdnems05.cdnsrv.jio.com/jiosaavn.cdn.jio.com/${no_id[i]}';
      Final_List_URL.add('$finalURL');
    }
    //print(SongDetails);
    //print(Final_List_URL);
    return Final_List_URL;
    //Navigator.push(context, 'route':(context)=>ChooseSong());
  }

  List No_id_list = [];
  Future<List> getNO(en_id) async {
    for (int i = 0; i < en_id.length; i++) {
      var noURL =
          'https://www.jiosaavn.com/api.php?__call=song.generateAuthToken&url=${en_id[i]}&bitrate=128&api_version=4&_format=json&ctx=wap6dot0&_marker=0';
      try {
        var response = await http.get(noURL);
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);

          var no_id = jsonResponse['auth_url'];
          int ind = no_id.indexOf('?');
          no_id = no_id.substring(27, ind);

          //print(no_id);
          No_id_list.add('$no_id');
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      } catch (e) {
        print(e);
      }
    }
    return await getFinalUrl(No_id_list);
  }

  List ID = [];
  Future<List> getID(token) async {
    for (int i = 0; i < token.length; i++) {
      var tokenURL =
          'https://www.jiosaavn.com/api.php?__call=webapi.get&token=${token[i]}&type=song&includeMetaTags=0&ctx=wap6dot0&api_version=4&_format=json&_marker=0';
      try {
        var response = await http.get(tokenURL);
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);

          var en_id =
              jsonResponse['songs'][0]['more_info']['encrypted_media_url'];

          //print('$en_id');
          en_id = en_id.replaceAll('+', '%2B');
          en_id = en_id.replaceAll('/', '%2F');
          print('$en_id');
          ID.add('$en_id');
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      } catch (e) {
        print(e);
      }
    }
    return await getNO(ID);
  }

  String imgUrl;
  String imgIconUrl;
  String titlee;
  var image;

  List SongDetails = [];
  List Tokens = [];
  Future<List> getToken(query) async {
    var queryURL =
        'https://www.jiosaavn.com/api.php?__call=autocomplete.get&query=$query&_format=json&_marker=0&ctx=wap6dot0';

    try {
      var response = await http.get(queryURL);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        for (int i = 0; i < 3; i++) {
          try {
            image = jsonResponse['songs']['data'][i]['image'];
          } catch (e) {
            //call others function
            break;
          }
          imgIconUrl = image;
          image = image.replaceAll('50x50', '500x500');
          imgUrl = image;
          var title = jsonResponse['songs']['data'][i]['title'];
          titlee = title;
          var description = jsonResponse['songs']['data'][i]['description'];
          var singers =
              jsonResponse['songs']['data'][i]['more_info']['singers'];
          var fulltoken = jsonResponse['songs']['data'][i]['url'];
          int l = fulltoken.length;
          var token = fulltoken.substring(l - 11, l);

          SongDetails.add(['$titlee', '$imgUrl', '$description', '$singers']);
          Tokens.add('$token');
        }
        List fff = await getID(Tokens);
        //List combi = [];
        for (int i = 0; i < fff.length; i++) {
          SongDetails[i].add('${fff[i]}');
        }
        return SongDetails;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }
}
