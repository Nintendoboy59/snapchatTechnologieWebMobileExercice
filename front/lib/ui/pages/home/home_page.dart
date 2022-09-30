import 'package:flutter/material.dart';
import 'package:snapchat_technologie_web_mobile_exercice/ui/pages/home/camera/camera_page.dart';
import 'package:snapchat_technologie_web_mobile_exercice/ui/pages/home/map/map_page.dart';
import 'package:snapchat_technologie_web_mobile_exercice/ui/pages/home/message/message_page.dart';
import 'package:snapchat_technologie_web_mobile_exercice/ui/pages/home/profil/profile_page.dart';
import 'package:snapchat_technologie_web_mobile_exercice/ui/pages/home/settings/settings_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _pages=[const MapPage(),const MessagePage(),const CameraPage(),const SettingsPage(), const ProfilePage()];
  int _selectedindex=0;
  MaterialColor _navBarItemColor= Colors.green;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: _pages[_selectedindex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: _navBarItemColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedindex,
          onTap: (index){
            setState(() {
              _selectedindex=index;
              if (_selectedindex==0){
                _navBarItemColor=Colors.green;
              }
              else if (_selectedindex==1){
                _navBarItemColor=Colors.blue;
              }
              else if (_selectedindex==2){
                _navBarItemColor=Colors.amber;
              }
              else if (_selectedindex==3){
                _navBarItemColor=Colors.deepPurple;
              }
              else {
                _navBarItemColor=Colors.red;
              }
            });
          },
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.location_pin),label: "Maps",backgroundColor: Colors.black),
            BottomNavigationBarItem(icon: Icon(Icons.messenger_outline_rounded),label: "Message",backgroundColor: Colors.black),
            BottomNavigationBarItem(icon: Icon(Icons.photo_camera_outlined),label: "Camera",backgroundColor: Colors.black),
            BottomNavigationBarItem(icon: Icon(Icons.group,),label: "Settings",backgroundColor: Colors.black),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: "Profile",backgroundColor: Colors.black),
          ],
        ),
      ),
    );;
  }
}
