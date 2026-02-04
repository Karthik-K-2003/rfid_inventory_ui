import 'package:flutter/material.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/utils/app_toast.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController itemUidController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();

  String? selectedCategory;
  String? selectedStatus;

  final List<String> categories = [
    "Electronics",
    "Grocery",
    "Clothing",
    "Furniture",
  ];

  final List<String> statuses = ["Active", "Inactive"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: itemUidController,
                    decoration: const InputDecoration(
                      labelText: "Item UID",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: itemNameController,
                    decoration: const InputDecoration(
                      labelText: "Item Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    hint: const Text("Select Category"),
                    items: categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedCategory = v),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedStatus,
                    hint: const Text("Select Status"),
                    items: statuses
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedStatus = v),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () async {
                if (itemUidController.text.isNotEmpty &&
                    itemNameController.text.isNotEmpty &&
                    selectedCategory != null &&
                    selectedStatus != null) {
                  await FirebaseService.addItem({
                    "uid": itemUidController.text,
                    "name": itemNameController.text,
                    "category": selectedCategory,
                    "status": selectedStatus,
                    "createdAt": DateTime.now().toIso8601String(),
                  });

                  AppToast.showSuccess(context, "Item added successfully");
                  Navigator.pop(context);
                }
              },
              child: const Text("Add Item"),
            ),
          ],
        ),
      ),
    );
  }
}
