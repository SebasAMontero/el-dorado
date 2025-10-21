import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:flutter/material.dart';

class GoldenCurveBackground extends StatelessWidget {
  const GoldenCurveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ClipPath(
        clipper: _GoldenCurveClipper(),
        child: Container(
          color: ColorConstants.primary,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
        ),
      ),
    );
  }
}

class _GoldenCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    path.quadraticBezierTo(size.width * 0.7, size.height * 0.4, size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(_GoldenCurveClipper oldClipper) => false;
}
