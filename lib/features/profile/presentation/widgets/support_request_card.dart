import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportRequestCard extends StatefulWidget {
  final String title;
  final String id;
  final String status;
  final String time;
  final bool isExpanded;
  final String description;

  const SupportRequestCard({
    super.key,
    required this.title,
    required this.id,
    required this.status,
    required this.time,
    this.isExpanded = false,
    required this.description,
  });

  @override
  State<SupportRequestCard> createState() => _SupportRequestCardState();
}

class _SupportRequestCardState extends State<SupportRequestCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.only(bottom: AppSizes.lgPadding),
      borderRadius: BorderRadius.circular(AppSizes.slRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppFonts.tajawalRegular16
                          .copyWith(color: AppColors.black10),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "${AppStrings.requestNumberLabel} ${widget.id}",
                      style: AppFonts.tajawalRegular14.copyWith(
                        color: AppColors.textGray,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.minOrgin,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  widget.status,
                  style: AppFonts.tajawalMedium16.copyWith(
                    color: AppColors.minOrginText,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Text(widget.time, style: AppFonts.tajawalMedium12),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      _isExpanded
                          ? AppStrings.hideDetails
                          : AppStrings.viewDetailsLabel,
                      style: AppFonts.tajawalRegular14.copyWith(
                        color: AppColors.black80,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.textGray99,
                      size: 20.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isExpanded) ...[
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "التفاصيل",
                style: AppFonts.tajawalRegular16
                    .copyWith(color: AppColors.textBlack),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              widget.description,
              style: AppFonts.tajawalRegular14.copyWith(
                color: AppColors.greyAA,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
