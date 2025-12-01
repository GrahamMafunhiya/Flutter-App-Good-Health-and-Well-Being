import 'package:flutter/material.dart';

void main() {
  runApp(WellnessDiaryApp());
}

class WellnessDiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellness Diary',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(),
      onGenerateRoute: (settings) {
        // Custom page transitions
        WidgetBuilder builder;
        switch (settings.name) {
          case '/mood':
            builder = (_) => MoodLogScreen();
            break;
          case '/vitals':
            builder = (_) => HealthVitalsScreen();
            break;
          case '/medicine':
            builder = (_) => MedicineScheduleScreen();
            break;
          default:
            builder = (_) => HomeScreen();
        }
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wellness Diary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Track Your Health & Mood',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              child: Text('Mood Log'),
              onPressed: () => Navigator.pushNamed(context, '/mood'),
            ),
            ElevatedButton(
              child: Text('Health Vitals'),
              onPressed: () => Navigator.pushNamed(context, '/vitals'),
            ),
            ElevatedButton(
              child: Text('Medicine Schedule'),
              onPressed: () => Navigator.pushNamed(context, '/medicine'),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- Mood Log Screen --------------------
class MoodLogScreen extends StatefulWidget {
  @override
  _MoodLogScreenState createState() => _MoodLogScreenState();
}

class _MoodLogScreenState extends State<MoodLogScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedMood;
  TextEditingController moodNoteController = TextEditingController();
  bool showSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mood Log')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                hint: Text('Select Mood'),
                value: selectedMood,
                validator: (value) => value == null ? 'Please select a mood' : null,
                items: ['😊 Happy', '😔 Sad', '😡 Angry', '😌 Calm']
                    .map((mood) => DropdownMenuItem(value: mood, child: Text(mood)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMood = value;
                  });
                },
              ),
              TextFormField(
                controller: moodNoteController,
                decoration: InputDecoration(labelText: 'Add a note about your mood'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a note' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save Mood'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      showSuccess = true;
                    });
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        showSuccess = false;
                      });
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: showSuccess ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.green, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Mood saved successfully!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------- Health Vitals Screen --------------------
class HealthVitalsScreen extends StatefulWidget {
  @override
  _HealthVitalsScreenState createState() => _HealthVitalsScreenState();
}

class _HealthVitalsScreenState extends State<HealthVitalsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController heartRateController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  bool showSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health Vitals')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: heartRateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Heart Rate (bpm)'),
                validator: (value) =>
                    value == null || int.tryParse(value) == null || int.parse(value) <= 0
                        ? 'Enter valid heart rate'
                        : null,
              ),
              TextFormField(
                controller: bpController,
                decoration: InputDecoration(labelText: 'Blood Pressure'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter blood pressure' : null,
              ),
              TextFormField(
                controller: tempController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Body Temperature (°C)'),
                validator: (value) =>
                    value == null || double.tryParse(value) == null || double.parse(value) <= 0
                        ? 'Enter valid temperature'
                        : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save Vitals'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      showSuccess = true;
                    });
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        showSuccess = false;
                      });
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: showSuccess ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.green, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Vitals saved successfully!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------- Medicine Schedule Screen --------------------
class MedicineScheduleScreen extends StatefulWidget {
  @override
  _MedicineScheduleScreenState createState() => _MedicineScheduleScreenState();
}

class _MedicineScheduleScreenState extends State<MedicineScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController medicineController = TextEditingController();
  bool reminderOn = false;
  bool showSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medicine Schedule')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: medicineController,
                decoration: InputDecoration(labelText: 'Medicine Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter medicine name' : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Set Reminder'),
                  Switch(
                    value: reminderOn,
                    onChanged: (val) {
                      setState(() {
                        reminderOn = val;
                      });
                    },
                  )
                ],
              ),
              ElevatedButton(
                child: Text('Save Medicine'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      showSuccess = true;
                    });
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        showSuccess = false;
                      });
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: showSuccess ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.green, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Medicine saved successfully!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
