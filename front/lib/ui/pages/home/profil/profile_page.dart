import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://rickandmortyapi.com/api/character/avatar/1.jpeg'),
                  radius: 50,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text('Jenny',
                  style: TextStyle(fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,fontSize: 25),
                ),
              ),
            ),
            const Center(
              child:Text('jenny98.12',
                style: TextStyle(fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,fontSize: 18),
              ),
            ),
            const Text('Friends',
            style: TextStyle(fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,fontSize: 24,fontStyle: FontStyle.normal),),
            Card(
              child: SizedBox(
                width: 350,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0,right: 20),
                        child: Icon(Icons.add_reaction_outlined),
                      ),
                      Text('Ajouter un ami',
                        style: TextStyle(fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,fontSize: 15),),
                      Padding(
                        padding: EdgeInsets.only(left: 150,),
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),
                ),
              ) ,
            ),
            Card(
              child: SizedBox(
                width: 350,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children:  const [
                      Padding( padding: EdgeInsets.only(left: 8,right: 20),
                      child: Icon(Icons.supervised_user_circle),),
                      Text('Mes Amis',
                        style: TextStyle(fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,fontSize: 15),),
                      Padding(
                        padding: EdgeInsets.only(left: 190,),
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),
                ),
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}
