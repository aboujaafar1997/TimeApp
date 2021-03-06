import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Word_Time {

  String location; // location name for UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDay;

  Word_Time({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try{
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      time = DateFormat.jm().format(now);
      isDay= await now.hour>6 && now.hour<20 ? true:false;
    }catch(e){
      time = 'cloud not get time data';
    }

  }

}