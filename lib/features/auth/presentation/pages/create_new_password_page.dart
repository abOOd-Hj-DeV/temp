// import 'package:etmaen/core/utils/regex.dart';
// import 'package:etmaen/features/auth/presentation/blocs/reset_password/reset_password_bloc.dart';
// import 'package:etmaen/features/auth/presentation/blocs/reset_password/reset_password_state.dart';
// import 'package:flutter/material.dart';
// import 'package:etmaen/core/constants/app_colors.dart';
// import 'package:etmaen/core/constants/app_strings.dart';
// import 'package:etmaen/features/auth/presentation/widget/auth_widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_modular/flutter_modular.dart';

// /// صفحة تسجيل الدخول بعد تطبيق العزل (تستخدم الودجتس المركزية)
// class CreateNewPasswordPage extends StatefulWidget {
//   const CreateNewPasswordPage({super.key});

//   @override
//   State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
// }

// class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _passwordController;
//   late TextEditingController _confirmPasswordController;

//   @override
//   void initState() {
//     super.initState();
//     _passwordController = TextEditingController();
//     _confirmPasswordController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
//       listener: (context, state) {
//         if (state is ResetPasswordFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.error)),
//           );
//         } else if (state is ResetPasswordSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//           Modular.to.navigate('/login');
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: AppColors.scaffoldBackground,
//           body: SafeArea(
//             child: SingleChildScrollView(
//               // SingleChildScrollView يمنع overflow على شاشات صغيرة
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Form(
//                 key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // عنوان الصفحة
//                       Header2(
//                         text: AppStrings.setpass,
//                         title_down: AppStrings.setpass2,
//                       ),
//                       const SizedBox(height: 18),
                  
//                       // حقل إدخال كلمة المرور الجديدة
//                       AuthTextField(
//                         controller: _passwordController,
//                         validator: (value) {
//                           if (value == null ||
//                               value.isEmpty ||
//                               !AppRegex.isEmailValid(value)) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                         label: AppStrings.newPassword,
//                         hintText: AppStrings.password,
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       const SizedBox(height: 16),
//                       // حقل إعادة إدخال كلمة المرور
//                       AuthTextField(
//                         controller: _confirmPasswordController,
//                         validator: (value) {
//                           if (value == null ||
//                               value.isEmpty ||
//                               !AppRegex.isPasswordValid(value)) {
//                             return 'At least 1 uppercase, 1 special character, and 1 number.';
//                           }
//                           return null;
//                         },
//                         label: AppStrings.renewPassword,
//                         hintText: AppStrings.password,
//                         keyboardType: TextInputType.emailAddress,
//                       ),
                  
//                       const SizedBox(height: 32),
                  
//                       // زر حفظ كلمة المرور
//                       AuthButton(
//                         text: AppStrings.startNow,
//                         onPressed: () {
//                           Modular.to.navigate('/enterotp');
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
