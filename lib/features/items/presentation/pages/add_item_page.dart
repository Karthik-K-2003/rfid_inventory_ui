import 'package:flutter/material.dart';
import '../../../../core/data/items_store.dart';
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
  void dispose() {
    itemUidController.dispose();
    itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item")),
      body: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1
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

            // Row 2
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    hint: const Text("Select Category"),
                    items: categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        selectedCategory = v;
                      });
                    },
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
                    onChanged: (v) {
                      setState(() {
                        selectedStatus = v;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                ),
                onPressed: () {
                  if (itemUidController.text.isNotEmpty &&
                      itemNameController.text.isNotEmpty &&
                      selectedCategory != null &&
                      selectedStatus != null) {
                    ItemsStore.items.add(
                      "${itemNameController.text} "
                      "(${selectedCategory!} - "
                      "${selectedStatus!})",
                    );

                    AppToast.showSuccess(context, "Item added");

                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Add Item",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
