import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQTile extends StatefulWidget {
  final String question;
  final String answer;
  final bool isExpanded;

  const FAQTile({
    super.key,
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  @override
  State<FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.xlPadding),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              children: [
                Text(
                  widget.question,
                  style: AppFonts.tajawalMedium16.copyWith(
                    color: AppColors.black0B,
                  ),
                ),
                const Spacer(),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.black0B,
                ),
              ],
            ),
          ),
          if (_isExpanded && widget.answer.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              widget.answer,
              textAlign: TextAlign.right,
              style: AppFonts.tajawalRegular14.copyWith(
                color: AppColors.greyAA,
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ],
      ),
    );
  }
}
