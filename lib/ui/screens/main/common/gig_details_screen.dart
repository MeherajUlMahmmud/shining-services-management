import 'package:flutter/material.dart';

class GigDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> gigDetails;

  const GigDetailsScreen({super.key, required this.gigDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gigDetails["name"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Details",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _buildInfoRow("Name", gigDetails["name"]),
            _buildInfoRow("Date", gigDetails["date"]),
            _buildInfoRow("Status", gigDetails["status"]),
            _buildInfoRow("Address", gigDetails["address"]),
            const SizedBox(height: 16),
            Text(
              "Team Members",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...gigDetails["teamMembers"].map<Widget>((member) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 20),
                    const SizedBox(width: 8),
                    Text(member, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            Text(
              "Services",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...gigDetails["services"].map<Widget>((service) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, size: 20, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(service, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
