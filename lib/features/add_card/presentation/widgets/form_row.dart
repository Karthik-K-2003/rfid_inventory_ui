import 'package:flutter/material.dart';

class FormRow extends StatelessWidget {
  final TextEditingController c1;
  final String label1;
  final TextEditingController c2;
  final String label2;

  const FormRow({
    super.key,
    required this.c1,
    required this.label1,
    required this.c2,
    required this.label2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: c1,
            decoration: InputDecoration(
              labelText: label1,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: c2,
            decoration: InputDecoration(
              labelText: label2,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
