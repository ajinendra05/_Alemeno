import 'dart:io';

import 'package:ajinendra/thanksmsg.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final riveFileName = 'assets/images/feedCat.riv';
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool pickIsClicked = false;
  bool isUploaded = false;
  var backImage;
  var obj;
  var path;
  var uploadTask;
  late Future<void> _initializeControllerFuture;

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      await controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  void pickImage() async {
    try {
      // await _initializeControllerFuture;
      final image = await controller!.takePicture();
      setState(() {
        pickIsClicked = true;
        backImage = FileImage(
          File(image.path),
        );
        path = 'feedImages/${image.name}';
        obj = File(image.path);
      });
    } catch (e) {
      print(e);
    }
  }

  void upload() async {
    final ref = FirebaseStorage.instance.ref().child(path);
    print("1");
    uploadTask = ref.putFile(obj).whenComplete(() {
      setState(() {
        isUploaded = true;
      });
      print("2");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageScreen(),
          ));
    });
  }

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(title: const  Text('Home')),
      body: Stack(children: [
        SizedBox(
          height: height * 0.45,
          width: width,
          child: RiveAnimation.asset(riveFileName),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.4),
          child: Container(
            height: height * 0.6,
            width: width,
            // color: const Color.fromARGB(255, 255, 250, 230),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 214, 212, 206),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                      child: pickIsClicked
                          ? SizedBox(
                              width: width * 0.8,
                              child: Stack(
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 50),
                                  //   child:
                                  //       Image.asset('assets/images/fass.png'),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(50),
                                    child: CircleAvatar(
                                      backgroundImage: backImage,
                                      radius: 100,
                                      child: const Center(),
                                    ),
                                  ),
                                ],
                              ))
                          : SizedBox(
                              width: width * 0.8,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child:
                                        Image.asset('assets/images/fass.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(50),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(500)),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: CameraPreview(controller!),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                    ),
                  ],
                ),
                Text(
                  pickIsClicked ? "Will you eat this?" : "Click your meal",
                  style: GoogleFonts.merriweather(
                    color: const Color.fromARGB(255, 75, 75, 75),
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 45,
                  child: Center(
                    child: IconButton(
                        onPressed: pickIsClicked ? upload : pickImage,
                        icon: Icon(
                          pickIsClicked
                              ? Icons.check
                              : Icons.camera_alt_outlined,
                          size: 30,
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
