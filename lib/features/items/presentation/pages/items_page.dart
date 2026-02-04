import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../../../../core/services/firebase_service.dart';
import 'add_item_page.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Items",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: FirebaseAnimatedList(
                query: FirebaseService.itemsRef(),

                // While loading
                defaultChild: const Center(child: CircularProgressIndicator()),

                itemBuilder: (context, snapshot, animation, index) {
                  // When list is empty
                  if (!snapshot.exists) {
                    return const Center(
                      child: Text(
                        "No items found",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  final data = snapshot.value as Map;
                  final key = snapshot.key!;

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.inventory),
                      title: Text(data['name']),
                      subtitle: Text("${data['category']} - ${data['status']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          FirebaseService.deleteItem(key);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Add Item"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddItemPage()),
          );
        },
      ),
    );
  }
}
