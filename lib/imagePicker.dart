import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

class UserImagePicker extends StatefulWidget {
  // final void Function(File x) imagePickerFn;
  const UserImagePicker({
    super.key,
  });

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  bool pickIsClicked = false;
  var backImage;
  CameraController? controller;
  List<CameraDescription>? cameras;
  late Future<void> _initializeControllerFuture;
  late CameraController _controller;

  Widget circularAvatarWidget = const Icon(
    Icons.camera_alt_outlined,
    size: 30,
  );
  void pickImage() async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and then get the location
      // where the image file is saved.
      final image = await _controller.takePicture();
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }
  //  async {
  //   // ClipRRect(
  //   //   borderRadius: BorderRadius.only(
  //   //     topLeft: Radius.circular(8.0),
  //   //     topRight: Radius.circular(8.0),
  //   //     bottomRight: Radius.circular(8.0),
  //   //     bottomLeft: Radius.circular(8.0),
  //   //   ),
  //   //   child: AspectRatio(
  //   //     aspectRatio: 1,
  //   //     child: CameraPreview(controller!),
  //   //   ),
  //   // );
  //   // final clickedImage =
  //   // await ImagePicker().pickImage(
  //   //   source: ImageSource.camera,
  //   //   preferredCameraDevice: CameraDevice.front,
  //   // );
  //   setState(() {
  //     pickIsClicked = true;
  //     backImage = FileImage(
  //       File(clickedImage!.path),
  //     );
  //   });
  //   // return widget.imagePickerFn(File(clickedImage!.path));
  // }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  @override
  void initState() {
    loadCamera();
    super.initState();
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 110,
      width: 110,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.only(top: height * 0.1),
          //           child: SizedBox(
          //               width: width * 0.8,
          //               child: Image.asset('assets/images/ac.png')),
          //         ),

          //       ],
          //     )
          // IconButton(onPressed: pickImage, icon: circularAvatarWidget),
          // ElevatedButton(
          //   onPressed: pickImage,
          //   child: Center(
          //     child: CircleAvatar(
          //       backgroundImage: backImage,
          //       radius: 45,
          //       child: pickIsClicked ? null : circularAvatarWidget,
          //     ),
          //   ),
          // ),
          Center(
            child: CircleAvatar(
              // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
              backgroundImage: backImage,
              radius: 45,
              child: pickIsClicked
                  ? null
                  : Center(
                      child: IconButton(
                          onPressed: pickImage, icon: circularAvatarWidget),
                    ),
            ),
          ),
        ],
      ),
    );
    // return ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //       shape: const CircleBorder(),
    //       shadowColor: const Color.fromARGB(0, 255, 193, 7),
    //       backgroundColor: const Color.fromARGB(0, 255, 255, 255)),
    //   onPressed: pickIsClicked ? null : pickImage,
    //   child: CircleAvatar(
    //     backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
    //     backgroundImage: backImage,
    //     radius: 45,
    //     child: pickIsClicked ? null : circularAvatarWidget,
    //   ),
    // );
  }
}
