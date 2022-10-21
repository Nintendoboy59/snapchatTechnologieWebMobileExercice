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
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FittedBox(
            child: Image.asset('assets/images/mapPicture.png'),
            fit: BoxFit.fill,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(
                  left: 0.0,
                  right: 5.0,
                  top: 10.0,
                  bottom: 5.0,
                ),
                child: GestureDetector(
                  onTap: () {
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
                )),
          ],
        ),
      ],
    );
  }
}
