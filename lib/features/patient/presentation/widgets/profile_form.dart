import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_fonts.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/core/utils/validators.dart';
import 'package:etmaen/features/auth/presentation/widget/auth_text_field.dart';
import 'package:etmaen/features/patient/data/models/patient_profile_model.dart';
import 'package:etmaen/features/patient/presentation/blocs/profile/profile_bloc.dart';
import 'package:etmaen/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

/// نموذج بيانات المريض المطلوبة في `PUT patients/profile`
class ProfileForm extends StatefulWidget {
  final PatientProfileModel? initial;
  final bool isSaving;
  final ValueChanged<ProfileSaveRequested> onSubmit;
  final VoidCallback? onCancel;

  const ProfileForm({
    super.key,
    this.initial,
    required this.isSaving,
    required this.onSubmit,
    this.onCancel,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  static const _genders = {
    'male': AppStrings.male,
    'female': AppStrings.female,
    'other': AppStrings.otherGender,
  };
  static const _languages = {'ar': 'العربية', 'en': 'English'};

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late String _gender;
  late String _language;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initial?.fullName);
    _ageController =
        TextEditingController(text: widget.initial?.age?.toString());
    _gender = _genders.containsKey(widget.initial?.gender)
        ? widget.initial!.gender
        : 'male';
    _language = _languages.containsKey(widget.initial?.language)
        ? widget.initial!.language
        : 'ar';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSubmit(ProfileSaveRequested(
      fullName: _nameController.text,
      age: int.parse(_ageController.text),
      gender: _gender,
      language: _language,
    ));
  }

  Widget _choiceRow(Map<String, String> options, String selected,
      ValueChanged<String> onChanged) {
    return Wrap(
      spacing: 8.w,
      children: options.entries
          .map((e) => ChoiceChip(
                label: Text(e.value),
                selected: selected == e.key,
                selectedColor: AppColors.primary.withValues(alpha: 0.15),
                onSelected: (_) => onChanged(e.key),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            label: AppStrings.fullName,
            hintText: AppStrings.fullNameHint,
            icon: Iconsax.user,
            controller: _nameController,
            validator: Validators.validateName,
          ),
          AuthTextField(
            label: AppStrings.age,
            hintText: AppStrings.ageHint,
            icon: Iconsax.calendar,
            controller: _ageController,
            keyboardType: TextInputType.number,
            validator: Validators.validateAge,
          ),
          Text(AppStrings.gender,
              style: AppFonts.tajawalMedium16
                  .copyWith(color: AppColors.textBlack)),
          SizedBox(height: 8.h),
          _choiceRow(_genders, _gender, (v) => setState(() => _gender = v)),
          SizedBox(height: 16.h),
          Text(AppStrings.language,
              style: AppFonts.tajawalMedium16
                  .copyWith(color: AppColors.textBlack)),
          SizedBox(height: 8.h),
          _choiceRow(
              _languages, _language, (v) => setState(() => _language = v)),
          SizedBox(height: 32.h),
          CustomButton(
            text: AppStrings.save,
            isLoading: widget.isSaving,
            onPressed: _submit,
            color: AppColors.primary,
            textColor: AppColors.white,
          ),
          if (widget.onCancel != null)
            TextButton(
              onPressed: widget.onCancel,
              child: const Text(AppStrings.cancel),
            ),
        ],
      ),
    );
  }
}
