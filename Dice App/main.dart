import 'package:flutter/material.dart';
import 'package:firstapp/graident_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 117, 71, 245),
          Color.fromARGB(255, 20, 2, 49),
        ),
      ),
    ),
  );
}

// void main() {
//   runApp(
//     const MaterialApp(
//       home: Scaffold(
//         body: GradientContainer.purple(),
//       ),
//     ),
//   );
// }
