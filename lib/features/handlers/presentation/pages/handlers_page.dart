import 'package:flutter/material.dart';
import '../../../../core/data/handlers_store.dart';

class HandlersPage extends StatefulWidget {
  const HandlersPage({super.key});

  @override
  State<HandlersPage> createState() => _HandlersPageState();
}

class _HandlersPageState extends State<HandlersPage> {
  @override
  Widget build(BuildContext context) {
    final handlers = HandlersStore.handlers;

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
            child: handlers.isEmpty
                ? const Center(
                    child: Text(
                      "No handlers added yet",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.separated(
                    itemCount: handlers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.person, color: Colors.blue),
                          title: Text(
                            handlers[index],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                HandlersStore.handlers.removeAt(index);
                              });
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
