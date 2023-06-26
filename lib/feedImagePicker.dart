import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

class imagePicker2 extends StatefulWidget {
  const imagePicker2({super.key});

  @override
  State<imagePicker2> createState() => _imagePicker2State();
}

class _imagePicker2State extends State<imagePicker2> {
  bool pickIsClicked = false;
  var backImage;
  CameraController? controller;
  List<CameraDescription>? cameras;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.1, right: width * 0.1),
            child: SizedBox(
                width: width * 0.8,
                child: Image.asset('assets/images/fass.png')),
          ),
        ],
      ),
    );
  }
}
