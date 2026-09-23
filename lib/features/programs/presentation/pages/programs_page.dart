import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/patient/presentation/blocs/programs/programs_bloc.dart';
import 'package:etmaen/features/patient/presentation/widgets/state_placeholder.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:etmaen/shared/widget/card.dart';
import 'package:etmaen/shared/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

/// البرامج العلاجية المتاحة (`GET patients/programs`)
class ProgramsPage extends StatelessWidget {
  const ProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProgramsBloc>()..add(const ProgramsRequested()),
      child: Scaffold(
        appBar: const CustomAppBar(title: AppStrings.programs),
        body: BlocBuilder<ProgramsBloc, ProgramsState>(
          builder: (context, state) {
            switch (state) {
              case ProgramsLoaded():
                if (state.programs.isEmpty) {
                  return const StatePlaceholder(
                    icon: Icons.menu_book_outlined,
                    message: AppStrings.noPrograms,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(AppSizes.lgPadding),
                  itemCount: state.programs.length,
                  itemBuilder: (context, index) {
                    final p = state.programs[index];
                    return CustomCard(
                      margin: EdgeInsets.only(bottom: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Iconsax.book_1,
                                  color: AppColors.primary),
                              SizedBox(width: 8.w),
                              Expanded(
                                child:
                                    Text(p.name, style: AppFonts.tajawalBold16),
                              ),
                              if (p.isCore)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.mdPadding,
                                    vertical: AppSizes.xsPadding,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.mintGreen,
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.lgRadius),
                                  ),
                                  child: Text(AppStrings.coreProgram,
                                      style: AppFonts.tajawalRegular12
                                          .copyWith(color: AppColors.primary)),
                                ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(p.description,
                              style: AppFonts.tajawalRegular14
                                  .copyWith(color: AppColors.textGray)),
                          SizedBox(height: 8.h),
                          Text('${p.modulesCount} ${AppStrings.modules}',
                              style: AppFonts.tajawalRegular12
                                  .copyWith(color: AppColors.textGray500)),
                        ],
                      ),
                    );
                  },
                );
              case ProgramsFailure():
                return StatePlaceholder(
                  icon: Icons.error_outline,
                  message: state.message,
                  onRetry: () => context
                      .read<ProgramsBloc>()
                      .add(const ProgramsRequested()),
                );
              default:
                return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary));
            }
          },
        ),
      ),
    );
  }
}
