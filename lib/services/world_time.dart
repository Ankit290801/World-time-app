import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {

  String location;  //user location
  String flag; //contry flag of the user
  var time;  //time to be displayed
  String url;  //url location of the of api endpoint
  late bool isDayTime; //true or false for daytime or not

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {

    try {
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);
      //print(data);

      //extract properties
      String datetime = data['datetime'];
      String offset_hours = data['utc_offset'].substring(1,3);
      String offset_mins = data['utc_offset'].substring(4,6);
      //print(datetime);
      //print(offset);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset_hours), minutes: int.parse(offset_mins)));
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('Error caused : $e');
      time = 'Could not fetch time';
    }
  }
    
}