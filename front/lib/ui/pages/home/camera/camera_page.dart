import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  CameraController? controller;
  VideoPlayerController? videoController;
  File? _imageFile;
  File? _videoFile;
  int _pageIndex = 0;

  // Initial values
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  bool _isRearCameraSelected = true;
  bool _isVideoCameraSelected = false;
  bool _isRecordingInProgress = false;
  bool _isDDropDownSelected = false;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;

  // Current values
  double _currentZoomLevel = 1.0;
  double _currentExposureOffset = 0.0;
  FlashMode? _currentFlashMode;

  List<File> allFileList = [];

  final resolutionPresets = ResolutionPreset.values;

  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  getPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      log('Camera Permission: GRANTED');
      setState(() {
        _isCameraPermissionGranted = true;
      });
      // Set and initialize the new camera
      onNewCameraSelected(await _getCamera(0));
      refreshAlreadyCapturedImages();
    } else {
      log('Camera Permission: DENIED');
    }
  }

  refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    fileList.forEach((file) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    });

    if (fileNames.isNotEmpty) {
      final recentFile =
          fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];
      if (recentFileName.contains('.mp4')) {
        _videoFile = File('${directory.path}/$recentFileName');
        _imageFile = null;
        _startVideoPlayer();
      } else {
        _imageFile = File('${directory.path}/$recentFileName');
        _videoFile = null;
      }

      setState(() {});
    }
  }

  Future<CameraDescription> _getCamera(int i) async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    return i == 1 ? cameras.first : cameras.last;
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  Future<void> _startVideoPlayer() async {
    if (_videoFile != null) {
      videoController = VideoPlayerController.file(_videoFile!);
      await videoController!.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });
      await videoController!.setLooping(true);
      await videoController!.play();
    }
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (controller!.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      return;
    }

    try {
      await cameraController!.startVideoRecording();
      setState(() {
        _isRecordingInProgress = true;
        print(_isRecordingInProgress);
      });
    } on CameraException catch (e) {
      print('Error starting to record video: $e');
    }
  }

  Future<XFile?> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }

    try {
      XFile file = await controller!.stopVideoRecording();
      setState(() {
        _isRecordingInProgress = false;
      });
      return file;
    } on CameraException catch (e) {
      print('Error stopping video recording: $e');
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Video recording is not in progress
      return;
    }

    try {
      await controller!.pauseVideoRecording();
    } on CameraException catch (e) {
      print('Error pausing video recording: $e');
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // No video recording was in progress
      return;
    }

    try {
      await controller!.resumeVideoRecording();
    } on CameraException catch (e) {
      print('Error resuming video recording: $e');
    }
  }

  void resetCameraValues() async {
    _currentZoomLevel = 1.0;
    _currentExposureOffset = 0.0;
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    resetCameraValues();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        cameraController
            .getMinExposureOffset()
            .then((value) => _minAvailableExposureOffset = value),
        cameraController
            .getMaxExposureOffset()
            .then((value) => _maxAvailableExposureOffset = value),
        cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value),
      ]);

      _currentFlashMode = controller!.value.flashMode;
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  @override
  void initState() {
    // Hide the status bar in Android
    SystemChrome.setEnabledSystemUIOverlays([]);
    getPermissionStatus();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isCameraPermissionGranted
          ? isCameraPermissionGranted()
          : isCameraPermissionNotGranted(),
      floatingActionButton: bareLaterale(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  @override
  Widget Loding() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  List<Widget> zommeAnContraste() {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _currentExposureOffset.toStringAsFixed(1) + 'x',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      Expanded(
        child: RotatedBox(
          quarterTurns: 3,
          child: Container(
            height: 30,
            child: Slider(
              value: _currentExposureOffset,
              min: _minAvailableExposureOffset,
              max: _maxAvailableExposureOffset,
              activeColor: Colors.white,
              inactiveColor: Colors.white30,
              onChanged: (value) async {
                setState(() {
                  _currentExposureOffset = value;
                });
                await controller!.setExposureOffset(value);
              },
            ),
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Slider(
              value: _currentZoomLevel,
              min: _minAvailableZoom,
              max: _maxAvailableZoom,
              activeColor: Colors.white,
              inactiveColor: Colors.white30,
              onChanged: (value) async {
                setState(() {
                  _currentZoomLevel = value;
                });
                await controller!.setZoomLevel(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _currentZoomLevel.toStringAsFixed(1) + 'x',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  @override
  Widget body() {
    List<Widget> _page = [
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: Colors.green,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CameraPreview(
              controller!,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (details) => onViewFinderTap(details, constraints),
                );
              }),
            ),
          ),
          photoBare()
        ],
      ),
      CapturesScreen(),
      PreviewScreen(),
    ];
    return _page[_pageIndex];
  }

  @override
  Widget isCameraPermissionGranted() {
    return _isCameraInitialized ? body() : Loding();
  }

  @override
  Widget isCameraPermissionNotGranted() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(),
        Text(
          'Permission denied',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            getPermissionStatus();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Give permission',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget bareLaterale() {
    return _pageIndex != 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black54,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                        setState(() {
                          _pageIndex = 0;
                        });
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 200,
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
                          onPressed: _isRecordingInProgress
                              ? () async {
                                  if (controller!.value.isRecordingPaused) {
                                    await resumeVideoRecording();
                                  } else {
                                    await pauseVideoRecording();
                                  }
                                }
                              : () async {
                                  setState(() {
                                    _isCameraInitialized = false;
                                  });
                                  onNewCameraSelected(_isRearCameraSelected
                                      ? await _getCamera(0)
                                      : await _getCamera(1));
                                  setState(() {
                                    _isRearCameraSelected =
                                        !_isRearCameraSelected;
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
                          height: 9,
                        ),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              _currentFlashMode =
                                  _currentFlashMode == FlashMode.off
                                      ? FlashMode.torch
                                      : FlashMode.off;
                              controller?.setFlashMode(_currentFlashMode!);
                            });
                          },
                          icon: Icon(
                            Icons.flash_on,
                            color: _currentFlashMode == FlashMode.torch
                                ? Colors.amberAccent
                                : Colors.white,
                            size: 24.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        _isDDropDownSelected
                            ? resolusionMode()
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isDDropDownSelected = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: Colors.white,
                                  size: 24.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  @override
  Widget photoBare() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: _imageFile != null || _videoFile != null
                  ? () {
                      setState(() {
                        _pageIndex = 1;
                      });
                    }
                  : null,
              icon: Icon(CommunityMaterialIcons.cards_playing_outline,
                  color: Colors.white, size: 28)),
          SizedBox(width: 15),
          GestureDetector(
            onLongPress: () async {
              _isVideoCameraSelected = true;
              await startVideoRecording();
            },
            onLongPressCancel: () async {
              if (_isRecordingInProgress) {
                XFile? rawVideo = await stopVideoRecording();
                File videoFile = File(rawVideo!.path);

                int currentUnix = DateTime.now().millisecondsSinceEpoch;

                final directory = await getApplicationDocumentsDirectory();

                String fileFormat = videoFile.path.split('.').last;

                _videoFile = await videoFile.copy(
                  '${directory.path}/$currentUnix.$fileFormat',
                );

                _startVideoPlayer();
                _isVideoCameraSelected = false;
              }
            },
            onTap: () async {
              XFile? rawImage = await takePicture();
              File imageFile = File(rawImage!.path);

              int currentUnix = DateTime.now().millisecondsSinceEpoch;

              final directory = await getApplicationDocumentsDirectory();

              String fileFormat = imageFile.path.split('.').last;

              print(fileFormat);

              await imageFile.copy(
                '${directory.path}/$currentUnix.$fileFormat',
              );

              refreshAlreadyCapturedImages();

              setState(() {
                _pageIndex = 2;
              });
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 7,
                      color:
                          _isVideoCameraSelected ? Colors.red : Colors.white)),
            ),
          ),
          SizedBox(width: 15),
          IconButton(
              onPressed: () async {
                setState(() {
                  _isCameraInitialized = false;
                });
                onNewCameraSelected(_isRearCameraSelected
                    ? await _getCamera(0)
                    : await _getCamera(1));
                setState(() {
                  _isRearCameraSelected = !_isRearCameraSelected;
                });
              },
              icon: Icon(CommunityMaterialIcons.sticker_emoji,
                  color: Colors.white, size: 28)),
        ],
      ),
    );
  }

  @override
  Widget resolusionMode() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: DropdownButton<ResolutionPreset>(
            dropdownColor: Colors.black87,
            underline: Container(),
            value: currentResolutionPreset,
            items: [
              for (ResolutionPreset preset in resolutionPresets)
                DropdownMenuItem(
                  child: Text(
                    preset.toString().split('.')[1].toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  value: preset,
                )
            ],
            onChanged: (value) {
              setState(() {
                currentResolutionPreset = value!;
                _isCameraInitialized = false;
                _isDDropDownSelected = false;
              });
              onNewCameraSelected(controller!.description);
            },
            hint: Text("Select item"),
          ),
        ),
      ),
    );
  }

  @override
  Widget CapturesScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Captures',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                for (File path in allFileList)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          _imageFile = path;
                          _pageIndex = 2;
                        });
                      },
                      child: Image.file(
                        path,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget PreviewScreen() {
    return Column(
      children: [
        Expanded(
          child: Image.file(_imageFile!),
        ),
      ],
    );
  }
}
