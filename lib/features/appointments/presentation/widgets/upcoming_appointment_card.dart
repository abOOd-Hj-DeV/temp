import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/features/appointments/data/models/appointment_time.dart';
import 'package:etmaen/features/appointments/presentation/widgets/appointment_communication_row.dart';
import 'package:etmaen/features/appointments/presentation/widgets/appointment_date_label.dart';
import 'package:etmaen/features/appointments/presentation/widgets/appointment_note.dart';
import 'package:etmaen/features/appointments/presentation/widgets/appointment_session_badge.dart';
import 'package:etmaen/features/appointments/presentation/widgets/appointment_time_row.dart';
import 'package:etmaen/features/appointments/presentation/widgets/upcoming_appointment_actions.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  final AppointmentCardModel model;
  final VoidCallback onEdit;
  final VoidCallback onCancel;

  const UpcomingAppointmentCard({
    super.key,
    required this.model,
    required this.onEdit,
    required this.onCancel,
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
          Text(
            "${AppStrings.responseTimePrefix} ${model.responseTime}",
            style: AppFonts.tajawalRegular14.copyWith(
              color: AppColors.textGray500,
            ),
          ),
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
          SizedBox(height: 15.h),
          UpcomingAppointmentActions(
            onEdit: onEdit,
            onCancel: onCancel,
          ),
          SizedBox(height: 15.h),
          AppointmentNote(note: model.note),
        ],
      ),
    );
  }
}
