import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Row 1: Summary Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryCard(
                  "Total Gigs",
                  "50",
                  Icons.event,
                  Colors.blue,
                ),
                _buildSummaryCard(
                  "Employees",
                  "20",
                  Icons.people,
                  Colors.green,
                )
              ],
            ),
            const SizedBox(height: 24),
            // Row 2: Charts and Quick Actions
            _buildPieChart(),
            _buildBarChart(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Summary Card Widget
  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Pie Chart Widget
  Widget _buildPieChart() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.h)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Task Distribution",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 40,
                      color: Colors.blue,
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: Colors.green,
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: Colors.purple,
                    ),
                  ],
                  centerSpaceRadius: 40,
                  sectionsSpace: 4,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            // Legends
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendItem(Colors.blue, "Upcoming"),
                _buildLegendItem(Colors.green, "Ongoing"),
                _buildLegendItem(Colors.purple, "Completed"),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Helper function to build a legend item
  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.h),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  // Bar Chart Widget
  Widget _buildBarChart() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Monthly Gig Stats",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _buildBarGroup(1, 15, Colors.blue, "Jan"),
                    _buildBarGroup(2, 20, Colors.green, "Feb"),
                    _buildBarGroup(3, 25, Colors.purple, "Mar"),
                    _buildBarGroup(4, 18, Colors.orange, "Apr"),
                    _buildBarGroup(5, 30, Colors.red, "May"),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5, // Customize the interval of numbers
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final titles = ["Jan", "Feb", "Mar", "Apr", "May"];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              titles[value.toInt() - 1],
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${rod.toY.toInt()}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                    // touchCallback: (event) {},
                    allowTouchBarBackDraw: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Helper function to build bar groups
  BarChartGroupData _buildBarGroup(int x, double y, Color color, String title) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: y,
          color: color,
          width: 10,
          // Adjust bar width as needed
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          backDrawRodData:
              BackgroundBarChartRodData(show: false), // No background
        ),
      ],
      showingTooltipIndicators: [0], // Display tooltip for the first rod
    );
  }
}

// Detailed Report Screen (Placeholder)
class DetailedReportScreen extends StatelessWidget {
  const DetailedReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detailed Report")),
      body: const Center(child: Text("This is the detailed report view")),
    );
  }
}
