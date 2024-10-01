import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
myStyle(double fs,[Color ?clr,FontWeight ?fw]) {
  return GoogleFonts.readexPro(
    fontSize: fs,
    color: clr,
    fontWeight: fw,
  );
}
style(double fs,[Color ?clr,FontWeight ?fw]) {
  return GoogleFonts.nunito(
    fontSize: fs,
    color: clr,
    fontWeight: fw,
  );
}
Color third=Color(0xffE8FFFF);
Color BG=Color(0xffE9E3CB);
Color B=Color(0xffCECFBB);
Color BG2=Color(0xff5A7C76);


// BackgroundScreen class (from the second code)
class BackgroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        return Stack(
          children: [
            // Background container with gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF9AD3BC), // light blue-ish
                    Color(0xFF5EAAA8), // medium teal
                  ],
                ),
              ),
            ),
            // Positioned circles
            Positioned(
              top: -screenWidth * 0.25,
              left: -screenWidth * 0.25,
              child: Container(
                width: screenWidth * 0.7,
                height: screenWidth * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -screenWidth * 0.25,
              right: -screenWidth * 0.25,
              child: Container(
                width: screenWidth * 0.7,
                height: screenWidth * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
