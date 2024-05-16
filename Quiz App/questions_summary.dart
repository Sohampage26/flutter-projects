import 'package:adv_basics/summzry_item.dart';
import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return SummaryItem(data);
            },
          ).toList(),
        ),
      ),
    );
  }
}
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 300,
//       child: SingleChildScrollView(
//         child: Column(
//           children: summaryData.map(
//             (data) {
//               return Row(
//                 children: [
//                   Text(
//                     ((data['question_index'] as int) + 1).toString(),
//                     style: GoogleFonts.lato(color: Colors.white),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Text(
//                           data['question'] as String,
//                           style: GoogleFonts.lato(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           data['user_answer'] as String,
//                           style: GoogleFonts.lato(
//                               color: const Color.fromARGB(255, 197, 15, 242)),
//                         ),
//                         Text(
//                           data['correct_answer'] as String,
//                           style: GoogleFonts.lato(color: Colors.greenAccent),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ).toList(),
//         ),
//       ),
//     );
//   }
// }
