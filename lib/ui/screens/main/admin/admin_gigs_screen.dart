import 'package:flutter/material.dart';

import '../common/gig_details_screen.dart';

class AdminGigsScreen extends StatelessWidget {
  const AdminGigsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 3, // Upcoming, Ongoing, Completed
      child: Column(
        children: [
          // Tab Bar
          Container(
            color: theme.primaryColor,
            child: TabBar(
              labelColor:
                  theme.appBarTheme.titleTextStyle?.color ?? Colors.white,
              indicatorColor: theme.indicatorColor ?? Colors.white,
              unselectedLabelColor:
                  theme.appBarTheme.iconTheme?.color?.withOpacity(0.7) ??
                      Colors.white60,
              tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Ongoing"),
                Tab(text: "Completed"),
              ],
            ),
          ),
          // Tab Views
          Expanded(
            child: TabBarView(
              children: [
                _buildGigList(context, "Upcoming"),
                _buildGigList(context, "Ongoing"),
                _buildGigList(context, "Completed"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGigList(BuildContext context, String status) {
    final theme = Theme.of(context);

    // Dummy data
    final gigs = List.generate(
      5,
      (index) => {
        "name": "$status Gig ${index + 1}",
        "date": "2024-12-${index + 10}",
        "address": "123 Main St, City, Country",
        "teamMembers": ["John Doe", "Jane Smith"],
        "services": ["Cleaning", "Sanitizing"],
        "status": status,
      },
    );

    return ListView.builder(
      itemCount: gigs.length,
      itemBuilder: (context, index) {
        final gig = gigs[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: theme.cardTheme.color,
          shadowColor: theme.cardTheme.shadowColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            title: Text(
              gig["name"].toString(),
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              "Date: ${gig["date"]}\nStatus: ${gig["status"]}",
              style: theme.textTheme.bodyMedium,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: theme.iconTheme.color,
            ),
            onTap: () {
              // Navigate to Gig Details Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GigDetailsScreen(gigDetails: gig),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
