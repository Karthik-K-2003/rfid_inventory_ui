import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../core/services/firebase_service.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 24),

          // Cards Row
          Row(
            children: [
              _buildCountCard(
                title: "Total Items",
                icon: Icons.inventory,
                ref: FirebaseService.itemsRef(),
              ),
              const SizedBox(width: 24),
              _buildCountCard(
                title: "Handlers",
                icon: Icons.people,
                ref: FirebaseService.handlersRef(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountCard({
    required String title,
    required IconData icon,
    required DatabaseReference ref,
  }) {
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, snapshot) {
        int count = 0;

        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          final data = snapshot.data!.snapshot.value as Map;
          count = data.length;
        }

        return SizedBox(
          width: 300,
          height: 160,
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Icon(icon, size: 40, color: Colors.blue),
                  const SizedBox(width: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        count.toString(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
