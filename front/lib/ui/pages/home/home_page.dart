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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const MapPage(),
      const MessagePage(),
      CameraPage(),
      const SettingsPage(),
      const ProfilePage()
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: appBarCustom(),
        body: pages[_selectedIndex],
        bottomNavigationBar: bottomNavBarCustom(),
      ),
    );
  }

  appBarCustom() {
    return _selectedIndex == 1
        ? AppBar(
            leadingWidth: 100,
            automaticallyImplyLeading: true,
            leading: Row(
              children: const [
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://rickandmortyapi.com/api/character/avatar/1.jpeg'),
                    )),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(
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
              ],
            ),
            title: const Text("Chat",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    fontSize: 25)),
            backgroundColor: Colors.white,
            centerTitle: true,
            actions: const [
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: CircleAvatar(
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
        : null;
  }

  bottomNavBarCustom() {
    List<Color> colors = [
      Colors.green,
      Colors.blue,
      Colors.amber,
      Colors.deepPurple,
      Colors.red,
    ];
    Map<String, Icon> map = {
      "Maps": const Icon(Icons.location_pin),
      "Message": const Icon(Icons.messenger_outline_rounded),
      "Camera": const Icon(Icons.photo_camera_outlined),
      "Settings": Icon(Icons.group),
      "Profile": const Icon(Icons.account_circle_outlined),
    };
    List<BottomNavigationBarItem> bottomNavigationBarItemList = [];
    map.forEach(
      (key, value) => bottomNavigationBarItemList.add(
        BottomNavigationBarItem(
          icon: value,
          label: key,
          backgroundColor: Colors.black,
        ),
      ),
    );
    return BottomNavigationBar(
      selectedItemColor: colors[_selectedIndex],
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: bottomNavigationBarItemList,
    );
  }
}
