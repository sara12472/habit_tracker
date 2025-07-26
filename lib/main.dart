import 'package:flutter/material.dart';
import 'package:habit_tracker/habit_bank.dart';

void main() {
  runApp(habit_tracker());
}

class habit_tracker extends StatelessWidget {
  const habit_tracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(
            child: Text(
              'Habit Tracker App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: habit_page(),
          ),
        ),
      ),
    );
  }
}

class habit_page extends StatefulWidget {
  const habit_page({super.key});

  @override
  State<habit_page> createState() => _habit_pageState();
}

class _habit_pageState extends State<habit_page> {
  HabitBank habitBank = HabitBank();
  String feedBack = '';
  int goodHabit = 0;
  int badHabit = 0;

  void showDialogue(String userFeedback) {
    if (feedBack == 'Good') {
      goodHabit++;
    } else {
      badHabit++;
    }

    if (habitBank.isFinished()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Habit Checked Completed!'),
            content: Text(
              'You have $goodHabit Good Habit and $badHabit Bad Habits.',
            ),
            actions: [
              TextButton(
                child: Text('Restart'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  setState(() {
                    habitBank
                        .reset(); // Reset your quiz (you need to create this method)
                    feedBack = ''; // Clear the icons list
                  });
                },
              ),
              TextButton(
                child: Text('close'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      habitBank.nextHabit();
      feedBack = userFeedback;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Centered Habit + Feedback
        Expanded(
          flex: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                habitBank.getHabit(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.teal.shade900, fontSize: 25.0),
              ),
              SizedBox(height: 20),
              Text(
                feedBack,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Yes Button
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                showDialogue('Good');
              },
              child: Text(
                'Yes',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),

        // No Button
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                showDialogue('Bad');
              },
              child: Text(
                'No',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
