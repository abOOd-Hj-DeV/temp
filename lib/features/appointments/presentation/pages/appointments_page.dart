import 'package:etmaen/features/appointments/presentation/widgets/appointment_list.dart';
import 'package:etmaen/features/appointments/presentation/widgets/completed_appointment_list.dart';
import 'package:etmaen/shared/widget/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/constants/app_strings.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.appointments,
        ),
      ),
      body: Column(
        children: [
          CustomTabBar(
            selectedIndex: _selectedTabIndex,
            tabs: [
              AppStrings.upcomingTab,
              AppStrings.previousTab,
            ],
            onTabChanged: (index) {
              setState(
                () {
                  _selectedTabIndex = index;
                },
              );
            },
          ),
          Expanded(
            child: _selectedTabIndex == 0
                ? const AppointmentList()
                : const CompletedAppointmentList(),
          ),
        ],
      ),
    );
  }
}
