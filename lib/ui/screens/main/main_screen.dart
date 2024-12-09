import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shining_services_management/utils/constants.dart';

class MainScreen extends StatefulWidget {
  static const routeName = AppRoutes.mainScreenRouteName;

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settingsScreenRouteName);
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Main Screen"),
      ),
    );
  }
}
