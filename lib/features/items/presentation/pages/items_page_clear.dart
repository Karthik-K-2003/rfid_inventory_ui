// import 'package:flutter/material.dart';
// import '../../../../core/data/items_store.dart';

// class ItemsPage extends StatefulWidget {
//   const ItemsPage({super.key});

//   @override
//   State<ItemsPage> createState() => _ItemsPageState();
// }

// class _ItemsPageState extends State<ItemsPage> {
//   @override
//   Widget build(BuildContext context) {
//     final items = ItemsStore.items;

//     return Container(
//       color: Colors.grey.shade100,
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title + Clear button row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Items",
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     ItemsStore.clear();
//                   });
//                 },
//                 child: const Text("Clear All"),
//               ),
//             ],
//           ),

//           const SizedBox(height: 24),

//           Expanded(
//             child: items.isEmpty
//                 ? const Center(
//                     child: Text(
//                       "No items available",
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   )
//                 : ListView.separated(
//                     itemCount: items.length,
//                     separatorBuilder: (_, __) => const SizedBox(height: 12),
//                     itemBuilder: (context, index) {
//                       return Card(
//                         child: ListTile(
//                           leading: const Icon(Icons.inventory),
//                           title: Text(items[index]),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
