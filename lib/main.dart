import 'package:flutter/material.dart';
import 'core/widgets/app_navigation.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/add_card/presentation/pages/add_card_page.dart';
import 'features/items/presentation/pages/items_page.dart';
import 'features/handlers/presentation/pages/handlers_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardShell(),
    );
  }
}

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int selectedIndex = 0;

  final pages = [DashboardPage(), AddCardPage(), ItemsPage(), HandlersPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppNavigationRail(
            selectedIndex: selectedIndex,
            onSelect: (i) => setState(() => selectedIndex = i),
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade100,
              child: pages[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
