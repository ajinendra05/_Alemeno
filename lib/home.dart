import 'package:ajinendra/feedScreen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final riveFileName = 'assets/images/catWalk.riv';
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
            child: Center(
              child: ElevatedButton(
                // style: ElevatedButton.styleFrom(shape: BorderRadius.circular(15)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedPage(),
                      ));
                },
                child: Text(
                  "Share your meal",
                  style: GoogleFonts.merriweather(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
