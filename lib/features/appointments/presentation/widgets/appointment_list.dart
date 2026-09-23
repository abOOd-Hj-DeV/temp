import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/appointments/data/models/appointment_time.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/features/appointments/presentation/widgets/upcoming_appointment_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentList extends StatelessWidget {
  const AppointmentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: AppSizes.xlPadding.h),
      itemCount: 3,
      itemBuilder: (context, index) {
        return UpcomingAppointmentCard(
          model: AppointmentCardModel(
            note: AppStrings.appointmentNoteReminder,
            responseTime: AppStrings.appointmentResponseTime,
            sessionNumber: index + 1,
            dateLabel: AppStrings.appointmentDateLabel,
            startTimeLabel: AppStrings.appointmentTimeLabel,
            durationMinutes: 50,
            communicationType: "chat",
            platform: "whatsapp",
          ),
          onEdit: () {},
          onCancel: () {},
        );
      },
    );
  }
}
