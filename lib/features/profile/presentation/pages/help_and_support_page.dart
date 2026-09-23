import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/profile/presentation/widgets/my_requests_tab.dart';
import 'package:etmaen/features/profile/presentation/widgets/new_request_tab.dart';
import 'package:etmaen/shared/widget/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        title: const Text(
          AppStrings.helpAndSupportTitle,
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.lgPadding.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                CustomTabBar(
                  margin: EdgeInsets.zero,
                  selectedIndex: _selectedTabIndex,
                  tabs: const [
                    AppStrings.myRequestsTab,
                    AppStrings.newRequestTab,
                  ],
                  onTabChanged: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          Expanded(
            child: _selectedTabIndex == 0
                ? const MyRequestsTab()
                : const NewRequestTab(),
          ),
        ],
      ),
    );
  }
}
