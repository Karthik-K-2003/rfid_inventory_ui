import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../../../../core/services/firebase_service.dart';

class HandlersPage extends StatelessWidget {
  const HandlersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Handlers",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          Expanded(
            child: FirebaseAnimatedList(
              query: FirebaseService.handlersRef(),
              itemBuilder: (context, snapshot, animation, index) {
                final data = Map<String, dynamic>.from(snapshot.value as Map);
                final key = snapshot.key!;

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.blue),
                    title: Text(
                      data['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${data['role']} - ${data['status']}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        FirebaseService.deleteHandler(key);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
