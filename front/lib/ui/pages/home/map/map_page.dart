import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset('assets/images/mapPicture.png'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(64),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (text) => const AlertDialog(
                        title: Text('Si t\'as pas d\'amis prends un curly'),
                      )
                  );
                },
                child: Container(
                  height: 55,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Text(
                      'Trouve tes amis',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
