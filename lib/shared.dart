import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();

  setListData(String key, List<String> value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList(key, value);
  }

  Future<List<String>> getListData(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getStringList(key);
  }
}
//
// class TrendingSongs {
//   var title;
//   var img;
//   var singer;
//   var encid;
//   List TrendSong = [];
//   List encidlist = [];
//   void getTrendingSongs() async {
//     var queryURL =
//         'https://www.jiosaavn.com/api.php?__call=webapi.get&token=I3kvhipIy73uCJW60TJk1Q__&type=playlist&p=1&n=50&includeMetaTags=0&ctx=wap6dot0&api_version=4&_format=json&_marker=0';
//
//     try {
//       var response = await http.get(queryURL);
//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         for (var i = 0; i < 50; i++) {
//           try {
//             title = jsonResponse['list'][i]['title'];
//             img = jsonResponse['list'][i]['image'];
//             singer = jsonResponse['list'][i]['more_info']['artistMap']
//                 ['primary_artists'][0]['name'];
//             encid = jsonResponse['list'][i]['more_info']['encrypted_media_url'];
//             encid = encid.replaceAll('+', '%2B');
//             encid = encid.replaceAll('/', '%2F');
//             encidlist.add(encid);
//             TrendSong.add(['$title', '$img', '$singer']);
//           } catch (e) {
//             print(e);
//           }
//         }
//         List temp = await getNO(encidlist);
//         for (var i = 0; i < TrendSong.length; i++) {
//           TrendSong[i].add('${temp[i]}');
//         }
//         print(TrendSong);
//       } else {
//         print('Request failed with status: ${response.statusCode}.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   List Final_List_URL = [];
//   Future<List> getFinalUrl(no_id) async {
//     for (int i = 0; i < no_id.length; i++) {
//       var finalURL =
//           'https://sklktecdnems05.cdnsrv.jio.com/jiosaavn.cdn.jio.com/${no_id[i]}';
//       Final_List_URL.add('$finalURL');
//     }
//     //print(SongDetails);
//     //print(Final_List_URL);
//     return Final_List_URL;
//     //Navigator.push(context, 'route':(context)=>ChooseSong());
//   }
//
//   List No_id_list = [];
//   Future<List> getNO(en_id) async {
//     for (int i = 0; i < en_id.length; i++) {
//       var noURL =
//           'https://www.jiosaavn.com/api.php?__call=song.generateAuthToken&url=${en_id[i]}&bitrate=128&api_version=4&_format=json&ctx=wap6dot0&_marker=0';
//       try {
//         var response = await http.get(noURL);
//         if (response.statusCode == 200) {
//           var jsonResponse = jsonDecode(response.body);
//
//           var no_id = jsonResponse['auth_url'];
//           int ind = no_id.indexOf('?');
//           no_id = no_id.substring(27, ind);
//
//           //print(no_id);
//           No_id_list.add('$no_id');
//         } else {
//           print('Request failed with status: ${response.statusCode}.');
//         }
//       } catch (e) {
//         print(e);
//       }
//     }
//     return await getFinalUrl(No_id_list);
//   }
// }
