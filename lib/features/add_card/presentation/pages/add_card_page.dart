import 'package:flutter/material.dart';
import '../../../../core/data/items_store.dart';
import '../widgets/form_row.dart';
import '../../../../core/data/handlers_store.dart';
import '../../../../core/utils/app_toast.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final TextEditingController handlerController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController itemIdController = TextEditingController();
  final TextEditingController itemQuantityController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();
  final TextEditingController itemExpiryDateController =
      TextEditingController();

  @override
  void dispose() {
    handlerController.dispose();
    itemController.dispose();
    itemIdController.dispose();
    itemQuantityController.dispose();
    itemPriceController.dispose();
    itemExpiryDateController.dispose();
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

              FormRow(
                c1: handlerController,
                label1: "Handler Name",
                c2: itemController,
                label2: "Item name",
              ),
              const SizedBox(height: 16),
              FormRow(
                c1: itemIdController,
                label1: "Item ID",
                c2: itemQuantityController,
                label2: "Item Quantity",
              ),
              const SizedBox(height: 16),
              FormRow(
                c1: itemPriceController,
                label1: "Item Price",
                c2: itemExpiryDateController,
                label2: "Item Expiry Date",
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
                    if (handlerController.text.isNotEmpty &&
                        itemController.text.isNotEmpty) {
                      HandlersStore.handlers.add(handlerController.text);
                      ItemsStore.items.add(itemController.text);

                      handlerController.clear();
                      itemController.clear();
                      itemIdController.clear();
                      itemQuantityController.clear();
                      itemPriceController.clear();
                      itemExpiryDateController.clear();

                      AppToast.showSuccess(context, "Item added");
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
