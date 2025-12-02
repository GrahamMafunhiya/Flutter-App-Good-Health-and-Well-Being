import 'package:flutter/material.dart';
import 'mood_check_page.dart';

class SavedEntriesPage extends StatelessWidget {
  const SavedEntriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Entries"),
        backgroundColor: Colors.teal,
      ),
      body: savedEntries.isEmpty
          ? const Center(
              child: Text(
                "No entries saved yet.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: savedEntries.length,
              itemBuilder: (context, index) {
                final entry = savedEntries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 14),
                  elevation: 4,
                  child: ListTile(
                    title: Text("Mood: ${entry['mood']}"),
                    subtitle: Text(
                        "Stress: ${entry['stress']} | Sleep: ${entry['sleep']} hrs\nAnxiety: ${entry['anxiety']}\nTime: ${entry['time']}"),
                  ),
                );
              },
            ),
    );
  }
}
