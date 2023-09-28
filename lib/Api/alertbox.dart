import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';

class CustomAlert {
  void showSuccessAlert(BuildContext context, String title, String message) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: title,
      text: message,
      confirmBtnText: "OK",
      onCancelBtnTap: () {
        Navigator.of(context).pop(); // Close the alert
      },
    );
  }

  void showWarningAlert(BuildContext context, String title, String message) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      title: title,
      text: message,
      confirmBtnText: "OK",
      onCancelBtnTap: () {
        Navigator.of(context).pop(); // Close the alert
      },
    );
  }

  void showErrorAlert(BuildContext context, String title, String message) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: title,
      text: message,
      confirmBtnText: "OK",
      onCancelBtnTap: () {
        Navigator.of(context).pop(); // Close the alert
      },
    );
  }
}
