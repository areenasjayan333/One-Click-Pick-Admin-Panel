import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void displaySnackBar({required String text, required BuildContext context}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      margin: const EdgeInsets.all(15),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: GoogleFonts.openSans(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    ),
  );
}
