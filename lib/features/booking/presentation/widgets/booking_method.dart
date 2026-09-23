import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/booking/data/models/booking_method_model.dart';
import 'package:etmaen/features/booking/presentation/blocs/booking_bloc.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class BookingMethod extends StatelessWidget {
  const BookingMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state.status == BookingStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }
        if (state.status == BookingStatus.failure) {
          return Center(child: Text(state.error ?? ''));
        }
        if (state.methods.isEmpty) {
          return const Center(child: Text(AppStrings.noAvailableMethods));
        }
        return _buildLodedState(state.methods);
      },
    );
  }
}

Widget _buildLodedState(List<BookingMethodModel> methods) {
  return Column(
    children: [
      _buildTitleAndIcon(
        text: AppStrings.selectCommunicationMethod,
        icon: Iconsax.headphone,
      ),
      Expanded(
        child: ListView.builder(
          itemCount: methods.length,
          itemBuilder: (context, index) => _buildMethodCard(
            onTap: () {
              context
                  .read<BookingBloc>()
                  .add(BookingMethodSelected(methods[index]));
            },
            descriptio: methods[index].method,
            title: methods[index].method,
          ),
        ),
      ),
    ],
  );
}

Widget _buildMethodCard(
    {required String title,
    required String descriptio,
    void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: CustomCard(
      margin: const EdgeInsets.all(AppSizes.xsPadding),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.tajawalBold18
                      .copyWith(color: AppColors.textBlackF1),
                ),
                Text(
                  descriptio,
                  style: AppFonts.tajawalMedium14
                      .copyWith(color: AppColors.textGray),
                ),
              ],
            ),
          ),
          Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 30.sp,
          ),
        ],
      ),
    ),
  );
}

Widget _buildTitleAndIcon({
  required String text,
  IconData? icon,
}) {
  return Row(
    spacing: AppSizes.smPadding,
    children: [
      Icon(icon),
      Text(
        text,
        style: AppFonts.tajawalMedium16.copyWith(color: AppColors.black10),
      ),
    ],
  );
}
