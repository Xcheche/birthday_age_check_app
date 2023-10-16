import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BirthdayScreen(),
    );
  }
}

class BirthdayCakeAnimation extends StatefulWidget {
  @override
  _BirthdayCakeAnimationState createState() => _BirthdayCakeAnimationState();
}

class _BirthdayCakeAnimationState extends State<BirthdayCakeAnimation> {
  double _cakeHeight = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _cakeHeight = 200.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      height: _cakeHeight,
      child: Image.asset('assets/images/happybufday.jpeg'),
    );
  }
}

class BirthdayScreen extends StatefulWidget {
  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  String? name;
  int? birthYear;
  int? age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 199, 199),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 123, 156, 172),
        title: const Text('Birthday App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Wrap the body in SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Enter your name:'),
              TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              Text('Enter your birth year:'),
              TextField(
                onChanged: (value) {
                  setState(() {
                    birthYear = int.tryParse(value);
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (birthYear != null) {
                    calculateAge();
                    _showBirthdayCake();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 123, 156, 172)),
                child: const Text('Calculate Age'),
              ),
              if (age != null)
                Text('Hello, $name! You are $age years old today.'),
              BirthdayCakeAnimation(),
            ],
          ),
        ),
      ),
    );
  }

  void calculateAge() {
    if (birthYear != null) {
      setState(() {
        age = DateTime.now().year - birthYear!;
      });
    }
  }

  void _showBirthdayCake() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Birthday Animation'),
          content: SingleChildScrollView(
            // Wrap the content in SingleChildScrollView
            child: Column(
              children: <Widget>[
                BirthdayCakeAnimation(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
