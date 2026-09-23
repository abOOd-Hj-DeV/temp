import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/appointments/presentation/pages/appointments_page.dart';
import 'package:etmaen/features/home/presentation/page/home_page.dart';
import 'package:etmaen/features/payment/presentation/pages/payment_page.dart';
import 'package:etmaen/features/profile/presentation/pages/profile_page.dart';
import 'package:etmaen/shared/widget/bottom_nav_bar.dart';
import 'package:etmaen/shared/widget/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CorePage extends StatefulWidget {
  const CorePage({super.key});

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const AppointmentsPage(),
    const PaymentPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        items: [
          CustomBottomNavigationBarItem(
            selectedIcon: Iconsax.profile_2user5,
            icon: Iconsax.profile_2user,
            text: AppStrings.bottomNavigationBarProfileItes,
            isSelected: _currentIndex == 3 ? true : false,
            onPressed: () {
              setState(() {
                _currentIndex = 3;
              });
            },
          ),
          CustomBottomNavigationBarItem(
            selectedIcon: Iconsax.card5,
            icon: Iconsax.card, //wallet
            text: AppStrings.bottomNavigationBarWalletItes,
            isSelected: _currentIndex == 2 ? true : false,
            onPressed: () {
              setState(() {
                _currentIndex = 2;
              });
            },
          ),
          CustomBottomNavigationBarItem(
            selectedIcon: Iconsax.calendar_25,
            icon: Iconsax.calendar_2,
            text: AppStrings.bottomNavigationBarAppointmentItes,
            isSelected: _currentIndex == 1 ? true : false,
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          CustomBottomNavigationBarItem(
            selectedIcon: Iconsax.home_15,
            icon: Iconsax.home,
            text: AppStrings.bottomNavigationBarHomeItes,
            isSelected: _currentIndex == 0 ? true : false,
            onPressed: () {
              setState(() {
                _currentIndex = 0;
              });
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
