import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/alert_dialog_helper.dart';
import 'package:etmaen/features/booking/presentation/block/booking_cubit.dart';
import 'package:etmaen/features/booking/presentation/block/booking_state.dart';
import 'package:etmaen/features/booking/presentation/widgets/booking_confirmation.dart';
import 'package:etmaen/features/booking/presentation/widgets/booking_date.dart';
import 'package:etmaen/features/booking/presentation/widgets/booking_hedar.dart';
import 'package:etmaen/features/booking/presentation/widgets/booking_method.dart';
import 'package:etmaen/features/booking/presentation/widgets/booking_pages_list.dart';
import 'package:etmaen/features/booking/presentation/widgets/booking_time.dart';
import 'package:etmaen/shared/widget/custom_floatingAction_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress/step_progress.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _pageViewController = PageController();
  final List<Widget> pageList = [
    const BookingDate(),
    const BookingTime(),
    const BookingMethod(),
    const BookingConfirmation(),
  ];
  late StepProgressController _stepProgressController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    _stepProgressController =
        StepProgressController(totalSteps: pageList.length, initialStep: 0);
    _pageViewController.addListener(_onPageChanged);
    super.initState();
  }

  void _onPageChanged() {
    final newIndex = _pageViewController.page?.round() ?? 0;
    if (newIndex != _currentPageIndex) {
      setState(() {
        _currentPageIndex = newIndex;
      });
    }
  }

  @override
  void dispose() {
    _pageViewController.removeListener(_onPageChanged);
    _pageViewController.dispose();
    _stepProgressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state.status == BookingStatus.success) {
          AlertService.showSuccess(context, message: AppStrings.bookingSuccess);
        }
        _updateStepProgress(state, _stepProgressController);
      },
      builder: (context, state) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _currentPageIndex == pageList.length - 1
            ? customFloatingActionButton(
                isLoading: state.status == BookingStatus.loading,
                text: AppStrings.bookConsultationSession,
                onPressed: () {
                  context.read<BookingCubit>().submitBooking();
                },
              )
            : null,
        body: CustomScrollView(
          slivers: [
            BookingPageHear(
              pageList: pageList,
              stepProgressController: _stepProgressController,
              pageViewController: _pageViewController,
              currentPageIndex: _currentPageIndex,
            ),
            SliverFillViewport(
              delegate: SliverChildListDelegate(
                [
                  BookingPagesList(
                    pageViewController: _pageViewController,
                    pageList: pageList,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _updateStepProgress(
    BookingState state, StepProgressController stepProgressController) {
  if (state.status == BookingStatus.timesLoaded) {
    stepProgressController.setCurrentStep(1);
  } else if (state.status == BookingStatus.methodsLoaded) {
    stepProgressController.setCurrentStep(2);
  } else if (state.status == BookingStatus.confirmed) {
    stepProgressController.setCurrentStep(3);
  }
}
