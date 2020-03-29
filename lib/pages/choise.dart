import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeapp/services/Word_Time.dart';
class Choise extends StatefulWidget {
  @override
  _ChoiseState createState() => _ChoiseState();
}

class _ChoiseState extends State<Choise> {
  List<Word_Time> locations = [
    Word_Time(url: 'Africa/Casablanca', location: 'Casablanca', flag: 'ma.png'),
    Word_Time(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    Word_Time(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    Word_Time(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    Word_Time(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    Word_Time(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    Word_Time(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    Word_Time(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    Word_Time(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];
  void updattime(index) async{
    Word_Time instance = Word_Time(location: locations[index].location, flag: locations[index].flag, url: locations[index].url);
    await instance.getTime();
    print("you chosie : "+instance.url);
    if(instance.time!='cloud not get time data' && instance.isDay!=null){
     Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDay': instance.isDay,
      'url':instance.url
    });
    }else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text("Ckeck you connection"),
            actions: [
              new FlatButton(
                child: const Text("Ok"),
                onPressed: (){
                  SystemNavigator.pop();
                },
              ),
            ],
          ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choise location"),
      ),
      body: ListView.builder(itemCount:locations.length,
      itemBuilder: (context,index){
        return Card(
          child:ListTile(
            onTap: (){
              updattime(index);
            },
            title: Text(locations[index].location),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/${locations[index].flag}"),
            ),
          ),
        );
      },
      ),
    );
  }
}
