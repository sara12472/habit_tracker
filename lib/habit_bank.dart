import 'habits.dart';

class HabitBank {
  int _habitCounter = 0;

  List<Habits> _habitlist = [
    Habits('Did you wake up before 8 AM?'),
    Habits('Did you drink 8 glasses of water today?'),
    Habits('Did you avoid junk food today?'),
    Habits('Did you do any physical exercise?'),
    Habits('Did you read a book for 15 minutes?'),
    Habits('Did you spend time with your family?'),
    Habits('Did you avoid social media in the morning?'),
    Habits('Did you go for a walk?'),
    Habits('Did you pray or meditate today?'),
    Habits('Did you go to bed on time?'),
  ];

  String getHabit() {
    return _habitlist[_habitCounter].habitsText;
  }

  void nextHabit() {
    if (_habitCounter < _habitlist.length - 1) {
      _habitCounter++;
    }
  }

  bool isFinished() {
    return _habitCounter >= _habitlist.length - 1;
  }

  void reset() {
    _habitCounter = 0;
  }
}
