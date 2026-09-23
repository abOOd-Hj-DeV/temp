import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/features/appointments/presentation/models/appointment_card_model.dart';
import 'package:etmaen/features/appointments/presentation/widgets/upcoming_appointment_card.dart';
import 'package:etmaen/features/patient/data/models/session_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentList extends StatelessWidget {
  final List<SessionModel> sessions;

  const AppointmentList({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: AppSizes.xlPadding.h),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        return UpcomingAppointmentCard(
          model: AppointmentCardModel.fromSession(sessions[index], index),
        );
      },
    );
  }
}
