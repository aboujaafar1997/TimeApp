import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:timeapp/services/Word_Time.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';

  void setupWorldTime() async {
    Word_Time instance = Word_Time(location: 'Casablanca', flag: 'ma.png', url: 'Africa/Casablanca');
    await instance.getTime();
    if(instance.time!='cloud not get time data'){
    setState(() {
      time = instance.time;
    });
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDay':instance.isDay,
        'url':instance.url
      });
    });
    }else {
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
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blue,
      body:
      Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 20.0),
            SpinKitFoldingCube(
              color: Colors.white,
              size: 50.0,
            ),
            Text("Power by othmane",style: TextStyle(color: Colors.white,fontSize: 20)),
          ],
        )
        )
      );

  }
}