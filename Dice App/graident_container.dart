import 'package:flutter/material.dart';
import 'package:firstapp/dice_roller.dart';
//import 'package:firstapp/styletext.dart';

const startAl = Alignment.topLeft;
const endAl = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer(
    this.c1,
    this.c2, {
    super.key,
  });

  // const GradientContainer.purple({super.key})
  //     : c1 = Colors.deepPurple,
  //       c2 = Colors.indigo;

  final Color c1;
  final Color c2;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [c1, c2],
          begin: startAl,
          end: endAl,
        ),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}

// class GradientContainer extends StatelessWidget {
//   const GradientContainer({super.key,required this.colors});

//   final List<Color> colors;

//   @override
//   Widget build(context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: colors,
//           begin: startAl,
//           end: endAl,
//         ),
//       ),
//       child: const Center(
//         child: StyleText('New Textt!!'),
//       ),
//     );
//   }
// }
