import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shining_services_management/cubits/user_cubit.dart';
import 'package:shining_services_management/models/user/user.dart';
import 'package:shining_services_management/ui/screens/main/admin/admin_dashboard_screen.dart';
import 'package:shining_services_management/ui/screens/main/admin/admin_employees_screen.dart';
import 'package:shining_services_management/ui/screens/main/admin/admin_gigs_screen.dart';
import 'package:shining_services_management/ui/screens/main/admin/admin_report_screen.dart';
import 'package:shining_services_management/ui/screens/main/crew_member/crew_member_dashboard_screen.dart';
import 'package:shining_services_management/ui/screens/main/crew_member/crew_member_report_screen.dart';
import 'package:shining_services_management/utils/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens for bottom navigation items
  List<Widget> _screens = [];
  List<String> _titles = [];

  @override
  void initState() {
    super.initState();
    // Trigger fetching user data from local storage
    context.read<UserCubit>().getUserFromLocal();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.isError) {
          return Scaffold(
            body: Center(
              child: Text(
                "Error: ${state.errorMessage ?? "Failed to load user information."}",
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final User? currentUser = state.currentUser;
        if (currentUser == null) {
          return const Scaffold(
            body: Center(
              child: Text("No user information available."),
            ),
          );
        }

        // Set up screens and titles based on user type
        if (currentUser.isAdmin) {
          _screens = [
            const AdminDashboardScreen(),
            const AdminGigsScreen(),
            const AdminEmployeesScreen(),
            const AdminReportScreen(),
          ];

          _titles = [
            "Dashboard",
            "Gigs",
            "Employees",
            "Reports",
          ];
        } else {
          _screens = [
            const CrewMemberDashBoardScreen(),
            const AdminGigsScreen(),
            const CrewMemberReportScreen(),
          ];

          _titles = [
            "Dashboard",
            "My Gigs",
            "Reports",
          ];
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(_titles[_selectedIndex]),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(
                      context, AppRoutes.settingsScreenRouteName);
                },
              ),
            ],
          ),
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            items: _buildBottomNavItems(currentUser),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavItems(User user) {
    if (user.isAdmin) {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: "Gigs",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: "Employees",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: "Reports",
        ),
      ];
    } else {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: "My Gigs",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: "Reports",
        ),
      ];
    }
  }
}
