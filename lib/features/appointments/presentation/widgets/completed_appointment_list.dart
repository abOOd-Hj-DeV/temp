import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/features/appointments/presentation/models/appointment_card_model.dart';
import 'package:etmaen/features/appointments/presentation/widgets/completed_appointment_card.dart';
import 'package:etmaen/features/patient/data/models/session_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedAppointmentList extends StatelessWidget {
  final List<SessionModel> sessions;

  const CompletedAppointmentList({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: AppSizes.xlPadding.h),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        return CompletedAppointmentCard(
          model: AppointmentCardModel.fromSession(sessions[index], index),
        );
      },
    );
  }
}
