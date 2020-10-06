import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomSong {
  List<List> finalList = [];
  List<String> temp = [];
  Future<String> getNO(en_id) async {
    var noURL =
        'https://www.jiosaavn.com/api.php?__call=song.generateAuthToken&url=$en_id&bitrate=128&api_version=4&_format=json&ctx=wap6dot0&_marker=0';
    try {
      var response = await http.get(noURL);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var no_id = jsonResponse['auth_url'];
        int ind = no_id.indexOf('?');
        no_id = no_id.substring(27, ind);

        String finalURL =
            'https://sklktecdnems05.cdnsrv.jio.com/jiosaavn.cdn.jio.com/$no_id';
        return finalURL;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List> getTokenforRandomSong() async {
    var queryURL =
        'https://www.jiosaavn.com/api.php?__call=webradio.getSong&stationid=ViJK7H0SzH3DQw5AXAF7U3EeY-Mp6UMpKwzeMURwYi2cMHuO1wQB-A__&k=5&next=1&api_version=4&_format=json&_marker=0&ctx=wap6dot0';
    try {
      var response = await http.get(queryURL);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var image = jsonResponse['0']['song']['image'];
        image = image.replaceAll('150x150', '500x500');
        var imgUrl = image;
        var title = jsonResponse['0']['song']['title'];

        var fulltoken =
            jsonResponse['0']['song']['more_info']['encrypted_media_url'];
        var en_id = fulltoken.replaceAll('+', '%2B');
        en_id = en_id.replaceAll('/', '%2F');
        String finalen_id = await getNO(en_id);
        //print(imgUrl+' '+title+' '+en_id);
        this.temp.add('$imgUrl');
        this.temp.add('$title');
        this.temp.add('$finalen_id');

        this.finalList.add(temp);

        temp = [];

        image = jsonResponse['1']['song']['image'];
        //imgIconUrl = image;
        image = image.replaceAll('150x150', '500x500');
        imgUrl = image;
        title = jsonResponse['1']['song']['title'];

        fulltoken =
            jsonResponse['1']['song']['more_info']['encrypted_media_url'];
        en_id = fulltoken.replaceAll('+', '%2B');
        en_id = en_id.replaceAll('/', '%2F');
        finalen_id = await getNO(en_id);
        //print(imgUrl+' '+title+' '+en_id);
        this.temp.add('$imgUrl');
        this.temp.add('$title');
        this.temp.add('$finalen_id');

        this.finalList.add(temp);
        //print(this.finalList);
        temp = [];

        image = jsonResponse['2']['song']['image'];
        //imgIconUrl = image;
        image = image.replaceAll('150x150', '500x500');
        imgUrl = image;
        title = jsonResponse['2']['song']['title'];

        fulltoken =
            jsonResponse['2']['song']['more_info']['encrypted_media_url'];
        en_id = fulltoken.replaceAll('+', '%2B');
        en_id = en_id.replaceAll('/', '%2F');
        finalen_id = await getNO(en_id);
        //print(imgUrl+' '+title+' '+en_id);
        this.temp.add('$imgUrl');
        this.temp.add('$title');
        this.temp.add('$finalen_id');

        this.finalList.add(temp);

        temp = [];

        image = jsonResponse['3']['song']['image'];
        //imgIconUrl = image;
        image = image.replaceAll('150x150', '500x500');
        imgUrl = image;
        title = jsonResponse['3']['song']['title'];

        fulltoken =
            jsonResponse['3']['song']['more_info']['encrypted_media_url'];
        en_id = fulltoken.replaceAll('+', '%2B');
        en_id = en_id.replaceAll('/', '%2F');
        finalen_id = await getNO(en_id);
        //print(imgUrl+' '+title+' '+en_id);
        this.temp.add('$imgUrl');
        this.temp.add('$title');
        this.temp.add('$finalen_id');

        this.finalList.add(temp);

        temp = [];

        image = jsonResponse['4']['song']['image'];
        //imgIconUrl = image;
        image = image.replaceAll('150x150', '500x500');
        imgUrl = image;
        title = jsonResponse['4']['song']['title'];

        fulltoken =
            jsonResponse['4']['song']['more_info']['encrypted_media_url'];
        en_id = fulltoken.replaceAll('+', '%2B');
        en_id = en_id.replaceAll('/', '%2F');
        finalen_id = await getNO(en_id);
        //print(imgUrl+' '+title+' '+en_id);
        this.temp.add('$imgUrl');
        this.temp.add('$title');
        this.temp.add('$finalen_id');

        this.finalList.add(temp);
        return this.finalList;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }
}
