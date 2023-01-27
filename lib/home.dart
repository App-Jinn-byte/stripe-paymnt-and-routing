import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/stripe/payment_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Transform.rotate(
          angle: 0,
          child: ClipPath(
            clipper: MyCustomClipper(),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Payment(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "   Hallo     ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.2750000, size.height * 0.1020000);
    path0.cubicTo(
        size.width * 0.6021875,
        size.height * 0.1020000,
        size.width * 0.5771875,
        size.height * 0.1020000,
        size.width * 0.6862500,
        size.height * 0.1020000);
    path0.cubicTo(
        size.width * 0.8287500,
        size.height * 0.0735000,
        size.width * 0.8137500,
        size.height * 0.2265000,
        size.width * 0.8112500,
        size.height * 0.3000000);
    path0.quadraticBezierTo(size.width * 0.8043750, size.height * 0.6425000,
        size.width * 0.9643750, size.height * 0.8005000);
    path0.lineTo(0, size.height * 0.7940000);
    path0.quadraticBezierTo(size.width * 0.1489125, size.height * 0.5842600,
        size.width * 0.1396875, size.height * 0.3010000);
    path0.cubicTo(
        size.width * 0.1473500,
        size.height * 0.2512600,
        size.width * 0.1293750,
        size.height * 0.0825000,
        size.width * 0.2750000,
        size.height * 0.1020000);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
