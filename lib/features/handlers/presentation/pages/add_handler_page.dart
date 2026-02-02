import 'package:flutter/material.dart';
import '../../../../core/data/handlers_store.dart';

class AddHandlerPage extends StatefulWidget {
  const AddHandlerPage({super.key});

  @override
  State<AddHandlerPage> createState() => _AddHandlerPageState();
}

class _AddHandlerPageState extends State<AddHandlerPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Handler",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Handler Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                HandlersStore.handlers.add(controller.text);
                controller.clear();

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Handler added")));
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
