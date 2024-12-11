import 'package:flutter/material.dart';

class AdminEmployeesScreen extends StatefulWidget {
  const AdminEmployeesScreen({super.key});

  @override
  State<AdminEmployeesScreen> createState() => _AdminEmployeesScreenState();
}

class _AdminEmployeesScreenState extends State<AdminEmployeesScreen> {
  // Dummy employee data
  final List<Map<String, dynamic>> employees = [
    {"name": "John Doe", "role": "Cleaner", "email": "john@example.com"},
    {"name": "Jane Smith", "role": "Supervisor", "email": "jane@example.com"},
    {"name": "Mark Johnson", "role": "Technician", "email": "mark@example.com"},
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search employees...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
              const SizedBox(width: 4),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), // Circular button
                  padding: const EdgeInsets.all(16), // Adjust padding
                  elevation: 4, // Shadow
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        // Employee List
        Expanded(
          child: ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              // Filter employees based on search query
              if (!employee["name"].toLowerCase().contains(searchQuery) &&
                  !employee["role"].toLowerCase().contains(searchQuery)) {
                return const SizedBox.shrink();
              }
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      employee["name"].substring(0, 1),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(employee["name"]),
                  subtitle: Text("${employee["role"]}\n${employee["email"]}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {
                      // Handle edit action
                    },
                  ),
                  onTap: () {
                    // Handle employee details navigation
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
