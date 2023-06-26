import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(title: const  Text('Home')),
      body: Container(
        height: height,
        width: width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: height * 0.45,
            width: width,
            child: Image.asset('assets/images/dog2.png'),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.1),
            child: Text(
              "GOOD JOB",
              style: GoogleFonts.montserrat(
                color: Colors.green,
                fontSize: 50.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
