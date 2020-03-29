import 'package:flutter/material.dart';
import "package:timeapp/services/Word_Time.dart";
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};
  String adresse="Allow GPS !";
  Location location = new Location();
  Map<String, double> userLocation;


  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

   void updater ()async{
     for(;;){
       _getLocation().then((value) async{
         final coordinates = new Coordinates(value["latitude"], value["longitude"]);
         var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
         var first = addresses.first;
         setState(() {
           adresse = "${first.addressLine}".split(" ")[1];
         });
       });
       await Future.delayed(const Duration(seconds: 3),()async{
           Word_Time instance = Word_Time(location: data['location'], flag: data['flag'], url: data['url']);
           await instance.getTime();
           print(data['time']+" --->"+instance.time);
           if(instance.time!="cloud not get time data" || instance.isDay!=null){
          setState(() {
          data = {
          'time': instance.time,
          'location': instance.location,
          'isDay': instance.isDay,
          'flag': instance.flag,
          'url':instance.url,
          };

          });

         }
     });
    }
  }
  @override
  void initState() {
    super.initState();
    updater();
  }
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String bkg=data["isDay"]?"day.png":"night.png";
    Color bc=data["isDay"]?Colors.blue:Colors.blue[900];
    return Scaffold(
      backgroundColor: bc,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image : AssetImage("assets/$bkg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(onPressed: ()async{
                     dynamic result = await Navigator.pushNamed(context, '/location');
                     if(result != null && result['isDay']!=null){
                       setState(() {
                         data = {
                           'time': result['time'],
                           'location': result['location'],
                           'isDay': result['isDay'],
                           'flag': result['flag'],
                           'url':result['url'],
                         };
                       });
                     }
                     },
                      icon: Icon(Icons.edit_location,color:
                      Colors.white),
                      label: Text("Localistaion",style: TextStyle(color:
                      Colors.white)
                        )
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                          style: TextStyle(
                          fontSize: 28.0,
                          color:  Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['time'],
                        style: TextStyle(
                          fontSize: 66.0,
                          color:  Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Your Position : $adresse',
                        style: TextStyle(
                          fontSize: 18.0,
                          color:  Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
