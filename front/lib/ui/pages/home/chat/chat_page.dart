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
  final List<Widget> _pages = [
    const MapPage(),
    const MessagePage(),
    const CameraPage(),
    const SettingsPage(),
    const ProfilePage()
  ];
  int _selectedindex = 0;
  MaterialColor _navBarItemColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: _selectedindex == 1
              ? AppBar(
                  leading: Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://rickandmortyapi.com/api/character/avatar/1.jpeg'),
                        radius: 50,
                      )),
                  title: Row(children: const <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              onPressed: (null),
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                            ))),
                    Text("Chat",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                            fontSize: 25))
                  ]),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  actions: [
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              onPressed: (null),
                              icon: Icon(
                                Icons.person_add,
                                color: Colors.black,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                            )))
                  ],
                )
              : null,
          body: _pages[_selectedindex],
        ),
      ),
    );
    ;
  }
}

class  extends StatelessWidget {
  const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class ChatPage extends StatelessWidget {
  const ChatPage({Key? key, this.character}) : super(key: key);
  final Result character;
  @override
  Widget build(BuildContext context) {
  return Container();
}
