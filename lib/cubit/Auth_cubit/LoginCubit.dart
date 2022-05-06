import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/BottomScreenCubit/ProfileCubit.dart';
import 'package:store/model/LoginModel.dart';
import 'package:store/shared/component/component.dart';
import 'package:store/shared/component/utils.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(AppInitLoginState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
  LoginModel? loginModel;
  void userLogin({required String phone ,required String password, context}){
    emit(getWattingLogin());
    DioHelper.postData(url: "auth/login",
        token: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODA4MVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY1MTAzMzY2NSwibmJmIjoxNjUxMDMzNjY1LCJqdGkiOiJJOHVVQ3BzZjl5eG1weW1rIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.yGtyvjr74BJm3v0MPI75fXeOqH_ZpEM_UzZkMkNM5bg",
        data: {
      "mobile":'$phone',
      "password":'$password',
      "device_token":firebaseToken

    }).then((value) {
      print(value.data.toString());

      showToast(msg: value.data['msg'], state: ToastStates.SUCCESS);
      loginModel = LoginModel.fromJson(value.data);
      dummyUser.name = loginModel!.user.name;
      dummyUser.city = loginModel!.user.city;
      dummyUser.city_id = loginModel!.user.city_id;
      dummyUser.region = loginModel!.user.region;
      dummyUser.region_id = loginModel!.user.region_id;
      dummyUser.mobile = loginModel!.user.mobile;
      dummyUser.gender = loginModel!.user.gender;
    CacheHelper.saveData(key: 'name', value: loginModel!.user.name);
    CacheHelper.saveData(key: 'city', value:loginModel!.user.city );
    CacheHelper.saveData(key: 'city_id', value:loginModel!.user.city_id );
    CacheHelper.saveData(key: 'region', value:loginModel!.user.region );
    CacheHelper.saveData(key: 'region_id', value: loginModel!.user.region_id);
    CacheHelper.saveData(key: 'mobile', value: loginModel!.user.mobile);
    CacheHelper.saveData(key: 'gender', value:loginModel!.user.gender );
    CacheHelper.saveData(key: "token", value: loginModel!.accessToken);

      emit(getScuessLogin(loginModel!));

    }).catchError((onError){
      print(onError.toString());
      emit(getErrorLogin(onError.toString()));
    });
  }




}

abstract class LoginStates {}
class AppInitLoginState extends LoginStates{}
class ShopChangePasswordVisibilityState extends LoginStates{}
class  getWattingLogin extends LoginStates{}
class  getScuessLogin extends LoginStates{
  final LoginModel loginModel;
  getScuessLogin(this.loginModel);
}
class  getErrorLogin extends LoginStates{
  final String error;
  getErrorLogin(this.error);
}