import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/appointments/presentation/widgets/appointment_list.dart';
import 'package:etmaen/features/appointments/presentation/widgets/completed_appointment_list.dart';
import 'package:etmaen/features/patient/presentation/blocs/appointments/appointments_bloc.dart';
import 'package:etmaen/features/patient/presentation/widgets/state_placeholder.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:etmaen/shared/widget/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AppointmentsBloc>()..add(const AppointmentsRequested()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(AppStrings.appointments),
        ),
        body: Column(
          children: [
            CustomTabBar(
              selectedIndex: _selectedTabIndex,
              tabs: const [AppStrings.upcomingTab, AppStrings.previousTab],
              onTabChanged: (index) =>
                  setState(() => _selectedTabIndex = index),
            ),
            Expanded(
              child: BlocBuilder<AppointmentsBloc, AppointmentsState>(
                builder: (context, state) {
                  switch (state) {
                    case AppointmentsLoaded():
                      final sessions = _selectedTabIndex == 0
                          ? state.appointments.upcoming
                          : state.appointments.past;
                      if (sessions.isEmpty) {
                        return const StatePlaceholder(
                          icon: Icons.event_available_outlined,
                          message: AppStrings.noAppointments,
                        );
                      }
                      return _selectedTabIndex == 0
                          ? AppointmentList(sessions: sessions)
                          : CompletedAppointmentList(sessions: sessions);
                    case AppointmentsProfileRequired():
                      return const StatePlaceholder(
                        icon: Icons.person_outline,
                        message: AppStrings.profileRequired,
                      );
                    case AppointmentsFailure():
                      return StatePlaceholder(
                        icon: Icons.error_outline,
                        message: state.message,
                        onRetry: () => context
                            .read<AppointmentsBloc>()
                            .add(const AppointmentsRequested()),
                      );
                    default:
                      return const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.primary),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
