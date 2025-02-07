
import '../model/user_model.dart';

class UserGenerics{
  bool isLoading;
  UserModel? users;
  UserGenerics({this.isLoading = false, this.users});

  UserGenerics update({bool? isLoading, UserModel? newUser}){
    return UserGenerics(
      isLoading: isLoading ?? this.isLoading,
        users: newUser ?? users
    );
  }
}