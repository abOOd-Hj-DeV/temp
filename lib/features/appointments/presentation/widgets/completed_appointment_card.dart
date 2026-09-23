import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/features/appointments/presentation/models/appointment_card_model.dart';
import 'package:etmaen/features/appointments/presentation/widgets/appointment_communication_row.dart';
import 'package:etmaen/features/appointments/presentation/widgets/appointment_date_label.dart';
import 'package:etmaen/features/appointments/presentation/widgets/appointment_session_badge.dart';
import 'package:etmaen/features/appointments/presentation/widgets/appointment_time_row.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedAppointmentCard extends StatelessWidget {
  final AppointmentCardModel model;
  const CompletedAppointmentCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.only(
        bottom: AppSizes.lgPadding,
        left: AppSizes.lgPadding,
        right: AppSizes.lgPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppointmentSessionBadge(sessionNumber: model.sessionNumber),
          SizedBox(height: 15.h),
          AppointmentDateLabel(label: model.dateLabel),
          SizedBox(height: 15.h),
          AppointmentTimeRow(
            timeLabel: model.startTimeLabel,
            durationMinutes: model.durationMinutes,
          ),
          SizedBox(height: 10.h),
          AppointmentCommunicationRow(
            type: model.communicationType,
            platform: model.platform,
          ),
          SizedBox(height: 10.h),
          AppointmentDateLabel(label: model.statusLabel),
        ],
      ),
    );
  }
}
