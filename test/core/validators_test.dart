import 'package:etmaen/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    test('كلمة السر أقل من 8 أحرف مرفوضة', () {
      expect(Validators.validatePassword('1234567'), isNotNull);
      expect(Validators.validatePassword('12345678'), isNull);
    });

    test('العمر خارج المدى مرفوض', () {
      expect(Validators.validateAge('5'), isNotNull);
      expect(Validators.validateAge('abc'), isNotNull);
      expect(Validators.validateAge('25'), isNull);
    });

    test('تأكيد كلمة السر يجب أن يطابق', () {
      expect(Validators.validateConfirmPassword('a1234567', 'b1234567'),
          isNotNull);
      expect(
          Validators.validateConfirmPassword('a1234567', 'a1234567'), isNull);
    });
  });
}
