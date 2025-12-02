import 'package:flutter/material.dart';

List<Map<String, String>> savedEntries = [];

class MoodCheckPage extends StatefulWidget {
  const MoodCheckPage({super.key});

  @override
  State<MoodCheckPage> createState() => _MoodCheckPageState();
}

class _MoodCheckPageState extends State<MoodCheckPage> {
  // Form controllers
  final TextEditingController moodController = TextEditingController();
  final TextEditingController stressController = TextEditingController();
  final TextEditingController sleepController = TextEditingController();
  final TextEditingController anxietyController = TextEditingController();

  String selectedMoodEmoji = "";

  // List of moods with emojis
  final List<Map<String, String>> emojiMoods = [
    {"emoji": "😀", "label": "Happy"},
    {"emoji": "😐", "label": "Neutral"},
    {"emoji": "😔", "label": "Sad"},
    {"emoji": "😡", "label": "Angry"},
    {"emoji": "😭", "label": "Crying"},
    {"emoji": "😴", "label": "Tired"},
  ];

  void saveEntry() {
    savedEntries.add({
      "mood": moodController.text,
      "stress": stressController.text,
      "sleep": sleepController.text,
      "anxiety": anxietyController.text,
      "time": DateTime.now().toString(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Entry Saved Successfully!")),
    );

    moodController.clear();
    stressController.clear();
    sleepController.clear();
    anxietyController.clear();
    selectedMoodEmoji = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Mental Health Check-In"),
        backgroundColor: Colors.teal,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    offset: Offset(0, 4),
                  )
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How are you feeling today?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 16),

                  // EMOJI MOOD PICKER
                  Wrap(
                    spacing: 10,
                    children: emojiMoods.map((m) {
                      bool selected = selectedMoodEmoji == m["emoji"];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMoodEmoji = m["emoji"]!;
                            moodController.text = m["label"]!;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: selected ? Colors.teal : Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            m["emoji"]!,
                            style: TextStyle(
                              fontSize: 28,
                              color: selected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  buildTextField("Mood (auto-filled when emoji selected)", moodController),
                  buildTextField("Stress Level (1–10)", stressController),
                  buildTextField("Hours of Sleep", sleepController),
                  buildTextField("Anxiety Level (Low, Medium, High)", anxietyController),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: saveEntry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Save Entry", style: TextStyle(fontSize: 18)),
                  ),

                  const SizedBox(height: 14),

                  OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, '/saved'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.teal, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "View Saved Entries",
                      style: TextStyle(color: Colors.teal, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF0F3F5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
