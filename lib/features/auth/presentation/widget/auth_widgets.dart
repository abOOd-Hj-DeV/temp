// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_strings.dart';

// /// ملف واحد يحوي ويدجتس قسم الأوث (قابلة لإعادة الاستخدام داخل auth)

// /// حقل إدخال مهيأ للاستخدام في صفحات الأوث
// class AuthTextField extends StatelessWidget {
//   final String label;
//   final String hintText;
//   final bool obscureText;
//   final TextInputType keyboardType;
//   final TextEditingController? controller;
//   final FormFieldValidator<String>? validator;

//   const AuthTextField({
//     super.key,
//     required this.label,
//     required this.hintText,
//     this.obscureText = false,
//     this.keyboardType = TextInputType.text,
//     this.controller,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Text(label, style: Theme.of(context).textTheme.bodyMedium),
//         const SizedBox(height: 8),
//         Container(
//           height: 52,
//           decoration: BoxDecoration(
//             color: AppColors.surface,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           alignment: Alignment.centerRight,
//           padding: const EdgeInsets.only(right: 16),
//           child: TextFormField(
//             validator: validator,
//             controller: controller,
//             obscureText: obscureText,
//             textAlign: TextAlign.right,
//             keyboardType: keyboardType,
//             style: GoogleFonts.plusJakartaSans(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: AppColors.textPrimary,
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: hintText,
//               hintStyle: Theme.of(context).textTheme.labelMedium,
//               isDense: true,
//               contentPadding: EdgeInsets.zero,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// الزر الرئيسي داخل صفحات الأوث
// class AuthButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final bool isLoading;

//   const AuthButton(
//       {super.key,
//       required this.text,
//       required this.onPressed,
//       this.isLoading = false});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         ),
//         child: (isLoading)
//             ? const CircularProgressIndicator(
//                 color: AppColors.white,
//               )
//             : Text(text, style: Theme.of(context).textTheme.labelLarge),
//       ),
//     );
//   }
// }

// /// Divider مع نص في الوسط (أو المتابعة عبر)
// class OrDivider extends StatelessWidget {
//   final String text;

//   const OrDivider({super.key, this.text = AppStrings.orContinueWith});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 0),
//       child: Row(
//         children: [
//           const Expanded(child: Divider(color: AppColors.lineDark, height: 1)),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Text(
//               text,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.plusJakartaSans(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//                 color: AppColors.lineDark,
//               ),
//             ),
//           ),
//           const Expanded(child: Divider(color: AppColors.lineDark, height: 1)),
//         ],
//       ),
//     );
//   }
// }

// /// زر تسجيل عبر شبكة خارجية (جوجل مثلاً)
// class SocialButton extends StatelessWidget {
//   final String iconPath;
//   final String text;
//   final VoidCallback onTap;

//   const SocialButton({
//     super.key,
//     required this.iconPath,
//     required this.text,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 32),
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.textPrimary, width: 1),
//           borderRadius: BorderRadius.circular(24),
//           color: Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 24,
//               height: 24,
//               child: Image.asset(iconPath,
//                   width: 24, height: 24, fit: BoxFit.contain),
//             ),
//             const SizedBox(width: 8),
//             Text(text,
//                 style: Theme.of(context)
//                     .textTheme
//                     .labelMedium
//                     ?.copyWith(color: AppColors.textPrimary)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AuthRichText extends StatelessWidget {
//   final String firstText; // النص العادي
//   final String secondText; // النص الملون (أو الأساسي)
//   final VoidCallback onPressed;

//   const AuthRichText({
//     super.key,
//     required this.firstText,
//     required this.secondText,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       textDirection: TextDirection.rtl,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(firstText, style: Theme.of(context).textTheme.bodyMedium),
//         InkWell(
//           onTap: () => onPressed,
//           child: Text(secondText,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyMedium
//                   ?.copyWith(color: AppColors.primary)),
//         )
//       ],
//     );
//   }
// }

// /// زر تسجيل عبر شبكة خارجية (جوجل مثلاً)
// class Header extends StatelessWidget {
//   final String Title;

//   const Header({
//     super.key,
//     required this.Title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       const SizedBox(height: 23),

//       // ⬅️ زر العودة + العنوان
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // زر العودة - شكل مطابق للتصميم
//           GestureDetector(
//             onTap: () {
//               if (Navigator.canPop(context)) Navigator.pop(context);
//             },
//             child: Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: AppColors.surface,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(
//                 Icons.arrow_back,
//                 color: AppColors.textPrimary,
//                 size: 24,
//               ),
//             ),
//           ),

//           // العنوان في الوسط
//           Text(Title, style: Theme.of(context).textTheme.titleLarge),

//           // نفس عرض الزر الأيسر كـ spacer بصري
//           const SizedBox(width: 40),
//         ],
//       ),

//       const SizedBox(height: 32),
//     ]);
//   }
// }

// class Header2 extends StatelessWidget {
//   final String title_down;
//   final String text;

//   const Header2({
//     super.key,
//     required this.title_down,
//     required this.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment:
//           CrossAxisAlignment.stretch, // يخلي العناصر تاخد عرض الشاشة
//       children: [
//         const SizedBox(height: 23),

//         // ⬅️ زر العودة + العنوان
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // زر العودة - شكل مطابق للتصميم
//             GestureDetector(
//               onTap: () {
//                 if (Navigator.canPop(context)) Navigator.pop(context);
//               },
//               child: Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: AppColors.surface,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Icon(
//                   Icons.arrow_back,
//                   color: AppColors.textPrimary,
//                   size: 24,
//                 ),
//               ),
//             ),

//             // العنوان في الوسط
//           ],
//         ),

//         const SizedBox(height: 48),

//         // النصوص محاذاة يمين
//         Align(
//           alignment: Alignment.centerRight,
//           child: SizedBox(
//             width: 180,
//             height: 20,
//             child: Text(
//               title_down,
//               textAlign: TextAlign.right,
//               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                     letterSpacing: 0.12, // kerning
//                   ),
//             ),
//           ),
//         ),

//         const SizedBox(height: 12),

//         Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             text,
//             textAlign: TextAlign.right,
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   letterSpacing: 0.08,
//                 ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// زر تسجيل عبر شبكة خارجية (جوجل مثلاً)
// class Header3 extends StatelessWidget {
//   final String Title;

//   final String head;

//   final String body;

//   const Header3({
//     super.key,
//     required this.Title,
//     required this.head,
//     required this.body,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 23),

//         // ⬅️ زر العودة + العنوان
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // زر العودة - شكل مطابق للتصميم
//             GestureDetector(
//               onTap: () {
//                 if (Navigator.canPop(context)) Navigator.pop(context);
//               },
//               child: Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: AppColors.surface,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Icon(
//                   Icons.arrow_back,
//                   color: AppColors.textPrimary,
//                   size: 24,
//                 ),
//               ),
//             ),

//             // العنوان في الوسط
//             Text(Title, style: Theme.of(context).textTheme.titleLarge),

//             // نفس عرض الزر الأيسر كـ spacer بصري
//             const SizedBox(width: 40),
//           ],
//         ),

//         const SizedBox(height: 36),

//         // النصوص بالوسط
//         Text(
//           head,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                 letterSpacing: 0.12, // kerning
//               ),
//         ),

//         const SizedBox(height: 8),

//         Text(
//           body,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 letterSpacing: 0.08,
//               ),
//         ),
//       ],
//     );
//   }
// }
