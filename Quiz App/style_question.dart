import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionStyle extends StatelessWidget {
  const QuestionStyle(this.qtext, {super.key});

  final String qtext;

  @override
  Widget build(BuildContext context) {
    return Text(
      qtext,
      style: GoogleFonts.lato(
        color: const Color.fromARGB(255, 228, 155, 255),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
