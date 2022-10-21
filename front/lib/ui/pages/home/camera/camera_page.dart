import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

class CameraPage extends StatefulWidget {
  static int i = 0;

  set range(int val) => i = val; // optionally perform validation, etc
  int get range => i;

  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  Future<CameraDescription> _getCamera(int i) async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    return i == 1 ? cameras.first : cameras.last;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCamera(CameraPage.i),
      builder:
          (BuildContext context, AsyncSnapshot<CameraDescription?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              TakePictureScreen(
                camera: snapshot.data!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black54,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 9,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  CameraPage.i = CameraPage.i == 0 ? 1 : 0;
                                });
                              },
                              icon: const Icon(
                                Icons.sync,
                                color: Colors.white,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Icon(
                              Icons.flash_on,
                              color: Colors.white,
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.white,
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  String _picture = "";
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _picture.isEmpty
        ? Scaffold(
            body: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_controller));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IconButton(
                //     onPressed: null,
                //     icon: Icon(CommunityMaterialIcons.cards_playing_outline,
                //         color: Colors.white, size: 28)),
                // SizedBox(width: 15),
                InkWell(
                  onTap: () async {
                    try {
                      await _initializeControllerFuture;
                      final image = await _controller.takePicture();
                      if (!mounted) return;
                      setState(() {
                        _picture = image.path;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 7, color: Colors.white)),
                  ),
                ),
                // SizedBox(width: 15),
                // IconButton(
                //     onPressed: null,
                //     icon: Icon(CommunityMaterialIcons.sticker_emoji,
                //         color: Colors.white, size: 28)),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat)
        : Scaffold(
            body: DisplayPictureScreen(imagePath: _picture),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _picture = "";
                });
              },
              child: const Icon(
                Icons.close,
                color: Colors.black,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endFloat);
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.file(File(imagePath)),
    );
  }
}
