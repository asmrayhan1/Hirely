import 'package:flutter/cupertino.dart';

import '../../shared/widgets/utils/toast.dart';

class Validation {

  static bool nameValidity({required String? name, required BuildContext context}){
    if (name == null || name.isEmpty || name.length < 3){
      // Toast.showToast(context: context, message: "Invalid Name!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool phoneValidity({required String? phone, required BuildContext context}){
    final phoneRegex = RegExp(r'^01[7|6|3|8|9|5]\d{8}$');
    if (phone == null || phone.isEmpty || phone.length != 11 || !phoneRegex.hasMatch(phone)){
      // Toast.showToast(context: context, message: "Invalid Phone Number!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }
  static bool phone({required String? phone}){
    final phoneRegex = RegExp(r'^01[7|6|3|8|9|5]\d{8}$');
    if (phone == null || phone.isEmpty || phone.length != 11 || !phoneRegex.hasMatch(phone)){
      return false;
    } else {
      return true;
    }
  }

  static bool addressValidity({required String? address, required BuildContext context}){
    if (address == null || address.isEmpty || address.length < 5){
      //Toast.showToast(context: context, message: "Invalid Address!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool emailValidity({required String? email, required BuildContext context}){
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email == null || email.isEmpty || !emailRegex.hasMatch(email)){
      //Toast.showToast(context: context, message: "Invalid Email format!", isWarning: true);
      return false;
    }  else {
      return true;
    }
  }

  static bool email({required String? email}){
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email == null || email.isEmpty || !emailRegex.hasMatch(email)){
      return false;
    }  else {
      return true;
    }
  }

  static bool passwordValidity({required String? password, required BuildContext context}){
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\d\s]).{6,}$');
    if (password == null || password.isEmpty || !passwordRegex.hasMatch(password)){
      //Toast.showToast(context: context, message: "Password should contain at least 6 characters!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool bioValidity({required String? bio, required BuildContext context}){
    if (bio == null || bio.isEmpty || bio.length < 5 || bio.length > 25){
      //Toast.showToast(context: context, message: "Bio length should be between 6-25 characters!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool descriptionValidity({required String? description, required BuildContext context}){
    if (description == null || description.isEmpty || description.length < 10 || description.length > 1000){
      //Toast.showToast(context: context, message: "Description length should be between 10-1000 characters!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

}