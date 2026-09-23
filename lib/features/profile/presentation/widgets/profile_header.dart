import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/auth/presentation/blocs/session/session_bloc.dart';
import 'package:etmaen/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// الجزء العلوي من صفحة الملف الشخصي (يعرض بيانات المستخدم من الجلسة)
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text(AppStrings.profile),
      titleTextStyle: AppFonts.tajawalBold18.copyWith(color: AppColors.white),
      expandedHeight: 140.h,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.all(AppSizes.lgPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<SessionBloc, SessionState>(
                builder: (context, state) {
                  final user =
                      state is SessionAuthenticated ? state.user : null;
                  return ProfileInfoCard(
                    name: user?.patient?.fullName.isNotEmpty == true
                        ? user!.patient!.fullName
                        : (user?.name ?? AppStrings.guest),
                    email: user?.whatsappNumber ?? '',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
