import 'package:flutter/material.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/utils/app_toast.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

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
  void dispose() {
    cardUidController.dispose();
    handlerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add Card",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Row 1: Card UID + Handler Name
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

              // Row 2: Role + Status
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedRole,
                      hint: const Text("Select Role"),
                      items: roles
                          .map(
                            (role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
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
                          .map(
                            (status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
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

              // Add Button
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
                  onPressed: () async {
                    if (cardUidController.text.isNotEmpty &&
                        handlerController.text.isNotEmpty &&
                        selectedRole != null &&
                        selectedStatus != null) {
                      await FirebaseService.addHandler({
                        "cardUid": cardUidController.text,
                        "name": handlerController.text,
                        "role": selectedRole,
                        "status": selectedStatus,
                        "createdAt": DateTime.now().toIso8601String(),
                      });

                      cardUidController.clear();
                      handlerController.clear();
                      setState(() {
                        selectedRole = null;
                        selectedStatus = null;
                      });

                      AppToast.showSuccess(context, "Card added successfully");
                    }
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
