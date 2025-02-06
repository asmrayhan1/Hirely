import 'package:flutter/cupertino.dart';

import '../../shared/widgets/utils/toast.dart';

class Validation {

  static bool nameValidity({required String? name, required BuildContext context}){
    if (name == null || name.isEmpty || name.length < 3){
      Toast.showToast(context: context, message: "Invalid Name!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool phoneValidity({required String? phone, required BuildContext context}){
    final phoneRegex = RegExp(r'^01[7|6|3|8|9|5]\d{8}$');
    if (phone == null || phone.isEmpty || phone.length != 11 || !phoneRegex.hasMatch(phone)){
      Toast.showToast(context: context, message: "Invalid Phone Number!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool addressValidity({required String? address, required BuildContext context}){
    if (address == null || address.isEmpty || address.length < 10){
      Toast.showToast(context: context, message: "Invalid Address!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool emailValidity({required String? email, required BuildContext context}){
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email == null || email.isEmpty || !emailRegex.hasMatch(email)){
      Toast.showToast(context: context, message: "Invalid Email format!", isWarning: true);
      return false;
    }  else {
      return true;
    }
  }

  static bool passwordValidity({required String? password, required BuildContext context}){
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\d\s]).{6,}$');
    if (password == null || password.isEmpty || !passwordRegex.hasMatch(password)){
      Toast.showToast(context: context, message: "Password should contain at least 6 characters!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool bioValidity({required String? bio, required BuildContext context}){
    if (bio == null || bio.isEmpty || bio.length < 6 || bio.length > 25){
      Toast.showToast(context: context, message: "Bio length should be between 6-25 characters!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool brandValidity({required String? brand, required BuildContext context}){
    if (brand == null || brand.length < 2 || brand.length > 10){
      Toast.showToast(context: context, message: "Brand length should be between 2-10 characters!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool itemValidity({required String? item, required BuildContext context}){
    if (item == null || item.isEmpty || item.length < 4 || item.length > 15){
      Toast.showToast(context: context, message: "Item length should be between 4-15 characters!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool descriptionValidity({required String? description, required BuildContext context}){
    if (description == null || description.isEmpty || description.length < 10 || description.length > 1000){
      Toast.showToast(context: context, message: "Description length should be between 10-1000 characters!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool priceValidity({required String? price, required BuildContext context}){
    bool isOkay = true;
    String num = "0123456789";
    for (int i = 0; i < price!.length; i++){
      bool okay = false;
      for (int j = 0; j < 10; j++){
        if (price[i] == num[j]) okay = true;
      }
      if (!okay){
        isOkay = false;
        break;
      }
    }
    if (!isOkay || price.length < 2 || price.length > 8){
      Toast.showToast(context: context, message: "Invalid Price!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool discountValidity({required String? discount, required BuildContext context}){
    bool isOkay = true;
    String num = "0123456789";
    for (int i = 0; i < discount!.length; i++){
      bool okay = false;
      for (int j = 0; j < 10; j++){
        if (discount[i] == num[j]) okay = true;
      }
      if (!okay){
        isOkay = false;
        break;
      }
    }
    if (!isOkay || discount.isEmpty || discount.length > 2){
      Toast.showToast(context: context, message: "Invalid Discount!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

  static bool countValidity({required String? count, required BuildContext context}){
    bool isOkay = true;
    String num = "0123456789";
    for (int i = 0; i < count!.length; i++){
      bool okay = false;
      for (int j = 0; j < 10; j++){
        if (count[i] == num[j]) okay = true;
      }
      if (!okay){
        isOkay = false;
        break;
      }
    }
    if (!isOkay || count.isEmpty || count.length > 8){
      Toast.showToast(context: context, message: "Invalid Total Item!", isWarning: true);
      return false;
    } else {
      return true;
    }
  }

}