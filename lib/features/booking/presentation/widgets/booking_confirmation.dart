import 'package:dotted_border/dotted_border.dart';
import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/functions.dart';
import 'package:etmaen/features/booking/presentation/blocs/booking_bloc.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iconsax/iconsax.dart';

class BookingConfirmation extends StatelessWidget {
  const BookingConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state.selectedDate == null ||
            state.selectedTime == null ||
            state.selectedMethod == null) {
          return const SizedBox.shrink();
        }
        final date = getArabicMonthAndDay(state.selectedDate!.date);
        final TherapistModel? therapistModel =
            Modular.args.data as TherapistModel?;
        return Column(
          children: [
            _buildTitleAndIcon(
                text: AppStrings.confirmBooking, icon: Iconsax.document),
            CustomCard(
              margin: const EdgeInsets.only(bottom: AppSizes.lgPadding),
              child: Column(
                children: [
                  _buildInfoItem(
                    descriptio: therapistModel?.name ?? '',
                    title: AppStrings.therapistLabel,
                  ),
                  _buildInfoItem(
                    descriptio: '${date.$2} ${date.$1}',
                    title: AppStrings.dateLabel,
                  ),
                  _buildInfoItem(
                    descriptio: state.selectedTime!.time,
                    title: AppStrings.timeLabel,
                  ),
                  _buildInfoItem(
                    descriptio: state.selectedMethod!.method,
                    title: AppStrings.methodLabel,
                  ),
                ],
              ),
            ),
            _buildTitleAndIcon(
              text: AppStrings.sessionPriceLabel,
              icon: Iconsax.card,
            ),
            _buildPimentInfoCard(
                price: '50£',
                descriptio:
                    'سعر رمزي للجلسة الأولية. ستصبح مجانية عند الاشتراك ببرنامج علاجي.')
          ],
        );
      },
    );
  }
}

Widget _buildPimentInfoCard(
    {required String descriptio, required String price}) {
  return CustomCard(
    border: Border.all(color: AppColors.primary, width: 2),
    margin: EdgeInsets.zero,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.priceLabel,
              style:
                  AppFonts.tajawalBold16.copyWith(color: AppColors.textGray36),
            ),
            Text(
              price,
              style: AppFonts.tajawalBold24.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        Text(
          descriptio,
          style:
              AppFonts.tajawalRegular16.copyWith(color: AppColors.textGray36),
        )
      ],
    ),
  );
}

Widget _buildInfoItem({required String title, required String descriptio}) {
  return DottedBorder(
    options: CustomPathDottedBorderOptions(
      dashPattern: [AppSizes.smPadding],
      strokeCap: StrokeCap.butt,
      strokeWidth: 2,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.mdPadding),
      color: AppColors.grayE6,
      customPath: (size) {
        return Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width, size.height);
      },
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: AppFonts.tajawalMedium16.copyWith(
            color: AppColors.textGray,
          ),
        ),
        Text(
          descriptio,
          style: AppFonts.tajawalRegular14.copyWith(
            color: AppColors.black10,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTitleAndIcon({
  required String text,
  IconData? icon,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: AppSizes.lgPadding),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.smPadding,
      children: [
        Icon(icon),
        Text(
          text,
          style: AppFonts.tajawalMedium16.copyWith(color: AppColors.black10),
        ),
      ],
    ),
  );
}
