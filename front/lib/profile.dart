import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://e7.pngegg.com/pngimages/482/584/png-clipart-bitstrips-snapchat-nose-millennials-eye-bitmoji-face-payment.png'),
                  radius: 50,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text('Jenny',
                  style: TextStyle(fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,fontSize: 25),
                ),
              ),
            ),
            Center(
              child:Text('jenny98.12',
                style: TextStyle(fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,fontSize: 18),
              ),
            ),
            Card(
              child: SizedBox(
                width: 350,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Ajouter un ami',
                    style: TextStyle(fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,fontSize: 15),),
                ),
              ) ,
            ),
            Card(
              child: SizedBox(
                width: 350,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Mes Amis',
                    style: TextStyle(fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,fontSize: 15),),
                ),
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}
