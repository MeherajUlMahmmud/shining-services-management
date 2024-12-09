import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shining_services_management/cubits/app_theme_cubit.dart';
import 'package:shining_services_management/cubits/auth_cubit.dart';
import 'package:shining_services_management/cubits/language_cubit.dart';
import 'package:shining_services_management/utils/constants.dart';
import 'package:shining_services_management/utils/helper.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = AppRoutes.settingsScreenRouteName;

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.accountAndSettings),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        children: [
          SizedBox(height: 12.h),
          _buildProfileSection(context),
          SizedBox(height: 12.h),
          _buildPointSection(context),
          SizedBox(height: 12.h),
          _buildSection(
            title: 'Offers',
            items: [
              _buildTile(
                context,
                icon: Icons.airplane_ticket,
                title: 'Refer and Earn points',
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.mainScreenRouteName),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildSection(
            title: 'Settings',
            items: _settingsItems(context),
          ),
          SizedBox(height: 12.h),
          _buildSection(
            title: 'Help & Legal',
            items: _helpItems(context),
          ),
          SizedBox(height: 12.h),
          _buildSection(
            title: 'More',
            items: _moreItems(context),
          ),
          SizedBox(height: 16.h),
          _buildSignOutButton(context),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Image.network(
              "https://avatar.iran.liara.run/public/5",
            ),
          ),
          const SizedBox(width: 10),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Meheraj",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text("01814325624"),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "4.7",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 0),
        leading: Icon(
          Icons.point_of_sale,
          size: 26.sp,
          color: Theme.of(context).primaryColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "SILVER",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              "732 Points",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color: Colors.grey,
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: Colors.grey[300]),
          ...items,
        ],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 0),
      leading: Icon(icon, size: 26.sp, color: Theme.of(context).primaryColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.sp,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  List<Widget> _settingsItems(BuildContext context) {
    final appThemeCubit = context.watch<AppThemeCubit>();
    final languageCubit = context.watch<LanguageCubit>();

    return [
      SwitchListTile(
        title: Text(
          "Dark Mode",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        value: appThemeCubit.state.selectedAppTheme == AppTheme.dark,
        onChanged: (value) {
          if (appThemeCubit.state.selectedAppTheme == AppTheme.dark) {
            appThemeCubit.setTheme(AppTheme.light);
          } else {
            appThemeCubit.setTheme(AppTheme.dark);
          }
        },
      ),
      SwitchListTile(
        title: Text(
          AppLocalizations.of(context)!.notifications,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        value: true,
        onChanged: (value) {
          // Handle toggle notifications
        },
      ),
      ListTile(
        title: Text(
          AppLocalizations.of(context)!.language,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(languageCubit.state.selectedLanguage.name),
        trailing: DropdownButton<String>(
          value: languageCubit.state.selectedLanguage.name,
          items: AppLanguage.values.map((language) {
            return DropdownMenuItem(
              value: language.name,
              child: Text(language.name),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null &&
                newValue != languageCubit.state.selectedLanguage.name) {
              final selectedLanguage = AppLanguage.values.firstWhere(
                (language) => language.name == newValue,
              );
              languageCubit.setLanguage(selectedLanguage);
            }
          },
        ),
      ),
      _buildTile(
        context,
        icon: Icons.admin_panel_settings,
        title: 'Permissions',
        onTap: () {},
      ),
      _buildTile(
        context,
        icon: Icons.notifications,
        title: 'Notifications',
        onTap: () {},
      ),
    ];
  }

  List<Widget> _helpItems(BuildContext context) {
    return [
      _buildTile(
        context,
        icon: Icons.live_help_outlined,
        title: 'Help',
        onTap: () {},
      ),
      _buildTile(
        context,
        icon: Icons.assignment,
        title: 'Terms & Conditions',
        onTap: () {},
      ),
      _buildTile(
        context,
        icon: Icons.lock,
        title: 'Privacy Policy',
        onTap: () {},
      ),
      _buildTile(
        context,
        icon: Icons.cookie,
        title: 'Cookie Policy',
        onTap: () {},
      ),
    ];
  }

  List<Widget> _moreItems(BuildContext context) {
    return [
      _buildTile(
        context,
        icon: Icons.contact_phone,
        title: 'Contact Us',
        onTap: () {},
      ),
      _buildTile(
        context,
        icon: Icons.help,
        title: 'FAQs',
        onTap: () {},
      ),
      _buildTile(
        context,
        icon: Icons.feedback,
        title: 'Feedback',
        onTap: () {},
      ),
    ];
  }

  Widget _buildSignOutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSignOutDialog(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.logout,
              color: Colors.white,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSignOutDialog(BuildContext context) async {
    final authCubit = context.read<AuthCubit>();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                authCubit.signOut();
                Helper().navigateAndClearStack(
                    context, AppRoutes.loginScreenRouteName);
              },
              child: const Text('Confirm', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
