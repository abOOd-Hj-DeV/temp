import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/appointments/data/models/appointment_time.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/features/appointments/presentation/widgets/completed_appointment_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedAppointmentList extends StatelessWidget {
  const CompletedAppointmentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: AppSizes.xlPadding.h),
      itemCount: 1,
      itemBuilder: (context, index) {
        return CompletedAppointmentCard(
          model: AppointmentCardModel(
            note: AppStrings.appointmentNoteReminder,
            responseTime: AppStrings.appointmentResponseTime,
            sessionNumber: 1,
            dateLabel: AppStrings.appointmentDateLabel,
            startTimeLabel: AppStrings.appointmentTimeLabel,
            durationMinutes: 50,
            communicationType: "chat",
            platform: "whatsapp",
          ),
          onViewReport: () {},
        );
      },
    );
  }
}
