(String, String) getArabicMonthAndDay(String dateStr) {
  // Parse the input date string into a DateTime object
  DateTime dateTime = DateTime.parse(dateStr);

  // Arabic month names list (Gregorian Calendar)
  final List<String> arabicMonths = [
    'يناير', // January
    'فبراير', // February
    'مارس', // March
    'أبريل', // April
    'مايو', // May
    'يونيو', // June
    'يوليو', // July
    'أغسطس', // August
    'سبتمبر', // September
    'أكتوبر', // October
    'نوفمبر', // November
    'ديسمبر' // December
  ];

  // Get the Arabic month name (Adjusting for 0-based index)
  String monthName = arabicMonths[dateTime.month - 1];

  // Get the day number as string
  String dayStr = dateTime.day.toString();

  // Mapping Latin numbers to Arabic digits
  final Map<String, String> arabicDigits = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩'
  };

  // Convert each digit of the day to Arabic
  String dayName = '';
  for (int i = 0; i < dayStr.length; i++) {
    dayName += arabicDigits[dayStr[i]] ?? dayStr[i];
  }

  // Return the Arabic month and day as a tuple (Record)
  return (monthName, dayName);
}
