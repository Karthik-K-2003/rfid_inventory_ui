import 'package:flutter/material.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/utils/app_toast.dart';

class AddCardPage extends StatefulWidget {
  final String? editKey;
  final Map? existingData;

  const AddCardPage({super.key, this.editKey, this.existingData});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final TextEditingController cardUidController = TextEditingController();
  final TextEditingController handlerController = TextEditingController();

  String? selectedRole;
  String? selectedStatus;

  final List<String> roles = ["Shopkeeper", "Manager", "Admin", "Security"];
  final List<String> statuses = ["Authorized", "Unauthorized"];

  @override
  void initState() {
    super.initState();

    if (widget.existingData != null) {
      cardUidController.text = widget.existingData!['cardUid'] ?? '';
      handlerController.text = widget.existingData!['name'] ?? '';

      final role = widget.existingData!['role'];
      final status = widget.existingData!['status'];

      selectedRole = roles.firstWhere(
        (r) => r.toLowerCase() == role,
        orElse: () => roles.first,
      );

      selectedStatus = statuses.firstWhere(
        (s) => s.toLowerCase() == status,
        orElse: () => statuses.first,
      );
    }
  }

  String sanitizeUid(String uid) {
    return uid.trim().replaceAll(RegExp(r'[.#$\[\]/]'), '_');
  }

  Future<void> _saveCard() async {
    final uid = sanitizeUid(cardUidController.text).toUpperCase();
    final name = handlerController.text.trim().toLowerCase();
    final role = selectedRole?.toLowerCase();
    final status = selectedStatus?.toLowerCase();

    if (uid.isEmpty || name.isEmpty || role == null || status == null) {
      AppToast.showSuccess(context, "Please fill all fields");
      return;
    }

    await FirebaseService.addHandler(uid, {
      "cardUid": uid,
      "name": name,
      "role": role,
      "status": status,
      "createdAt": DateTime.now().toIso8601String(),
    });

    Navigator.pop(context);
    AppToast.showSuccess(context, "Saved successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Card")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cardUidController,
                    decoration: const InputDecoration(
                      labelText: "Card UID",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: handlerController,
                    decoration: const InputDecoration(
                      labelText: "Handler Name",
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
                    value: selectedRole,
                    hint: const Text("Select Role"),
                    items: roles
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedRole = v),
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
            ElevatedButton(onPressed: _saveCard, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
