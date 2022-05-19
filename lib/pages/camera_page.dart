// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isFlashOn = false;
  bool isFrontCam = false;
  late CameraDescription frontCamera;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void rotateCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final frontCam = cameras.last;

    if (!isFrontCam) {
      _controller = CameraController(
        frontCam,
        ResolutionPreset.medium,
      );
      isFrontCam = true;
    } else {
      _controller = CameraController(
        widget.camera,
        ResolutionPreset.medium,
      );
      isFrontCam = false;
    }

    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(
            _controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  color: Color.fromARGB(25, 224, 224, 224),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 75,
                        width: 75,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                          ),
                          onPressed: () {
                            if (isFlashOn) {
                              _controller.setFlashMode(FlashMode.off);
                              isFlashOn = false;
                            } else {
                              _controller.setFlashMode(FlashMode.torch);
                              isFlashOn = true;
                            }
                            setState(() {});
                          },
                          child: Icon(
                            Icons.flash_on,
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 75,
                        width: 75,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                          ),
                          onPressed: () async {
                            try {
                              await _initializeControllerFuture;

                              final image = await _controller.takePicture();

                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DisplayPictureScreen(
                                    imagePath: image.path,
                                  ),
                                ),
                              );
                            } catch (e) {
                              // If an error occurs, log the error to the console.
                            }
                          },
                          child: Icon(
                            Icons.camera_alt,
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 75,
                        width: 75,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                          ),
                          onPressed: () {
                            rotateCamera();
                          },
                          child: Icon(
                            Icons.flip_camera_ios_rounded,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Center(child: Image.file(File(imagePath))),
      // body: Text("Photo Clicked"),
    );
  }
}
