class CoreHelper {
  static const savedUserKey = 'savedUserKey';
  static const googleAPIKey = 'AIzaSyAR4Yezxk7Ao4qeFntu7tIvE7pH28Eh64Y';

  static String validateAccount(String nameText, String accountNumberText,) {
    if (nameText.isEmpty) {
      return 'Please Enter the Account Name';
    } else if (accountNumberText.isEmpty) {
      return 'Please Enter the Account Number';
    }
    return null;
  }

  static String validateAmount(String amountText, String amountType) {
    if (amountText.isEmpty || double.tryParse(amountText) == null) {
      return 'Please Enter a valid $amountType amount';
    }
    return null;
  }
}