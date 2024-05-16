import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:adv_basics/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  List<String> selectedAnswers = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  void returnHome() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);
    if (activeScreen == 'questions-screen') {
      screenWidget = QuenstionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultScreen(
        chosenAnswer: selectedAnswers,
        onRestart: restartQuiz,
        returnHome: returnHome,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 78, 13, 151),
              Color.fromARGB(255, 107, 15, 168)
            ]),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}























// import 'package:adv_basics/questions_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:adv_basics/start_screen.dart';

// class Quiz extends StatefulWidget {
//   const Quiz({super.key});

//   @override
//   State<Quiz> createState() {
//     return _QuizState();
//   }
// }

// class _QuizState extends State<Quiz> {
//   var activeScreen = 'start-screen';

//   void switchScreen() {
//     setState(() {
//       activeScreen = 'questions-screen';
//     });
//   }

//   @override
//   Widget build(context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//               Color.fromARGB(255, 78, 13, 151),
//               Color.fromARGB(255, 107, 15, 168)
//             ]),
//           ),
//           child: activeScreen == 'start-screen'
//               ? StartScreen(switchScreen)
//               : const QuenstionsScreen(),
//         ),
//       ),
//     );
//   }
// }






































// import 'package:adv_basics/questions_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:adv_basics/start_screen.dart';

// class Quiz extends StatefulWidget {
//   const Quiz({super.key});

//   @override
//   State<Quiz> createState() {
//     return _QuizState();
//   }
// }

// class _QuizState extends State<Quiz> {
//   Widget? activeScreen;

//   @override
//   void initState() {
//     activeScreen = StartScreen(switchScreen);
//     super.initState();
//   }

//   void switchScreen() {
//     setState(() {
//       activeScreen = const QuenstionsScreen();
//     });
//   }

//   @override
//   Widget build(context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//               Color.fromARGB(255, 78, 13, 151),
//               Color.fromARGB(255, 107, 15, 168)
//             ]),
//           ),
//           child: activeScreen,
//         ),
//       ),
//     );
//   }
// }
