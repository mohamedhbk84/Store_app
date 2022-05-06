import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/model/getCity.dart';
import 'package:store/model/getRegion.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(AppInitRegisterState());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  var phoneController = TextEditingController();

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(ShopChangePasswordVisibilityState());
  }

  void getPhone({required String phone}){
    phoneController.text = phone;
    emit(AppGetPhone());
  }
  changeGender gender = changeGender.male;
  void changeRadio( value){
    gender = value;
    print(gender);
    emit(ChangeGenderState());
  }
  GetCity ? getCity;
  bool boolCity = false;
 Future<GetCity>? getDataCity() {
   boolCity = false;
    emit(AppWattingGetCity());
    DioHelper.getData(url: "getcity" ,token: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbG9jYXRpb25zdG9yLmNvbVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY1MTM4NDk1NywibmJmIjoxNjUxMzg0OTU3LCJqdGkiOiJ4MWl1YzNTc0FLNWRqdmJPIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.qm0w6xxfOtp8l2A4l07JkVV_MiCuwZELDDGQUh6sTrA").then((value) {
   getCity = GetCity.fromJson(value.data);
   print(getCity!.city.toString());
   boolCity= true;
   emit(AppSCUSESSXGetCity());
 return getCity;
    }).catchError((onError){
   print(onError.toString());
   boolCity= false;
   emit(AppErrorGetCity());
   return getCity;
    });
    return null;
  }

 String cityname= '';
 int idcity= 0;
  void changeCity(value){
    city = value;
    cityname =city!.cityName;
    idcity = city!.id;
    regions = null;
    getDataRegion(idCity: idcity);
    emit(AppChangeRegion ());
  }
  int id_region = 0 ;
  String regionname= '';
  void changeRegion(value){
    regions= value;
    id_region =regions!.id;
    regionname = regions!.regionName;
    emit(AppChangeRegion());
  }
  //////  region ////
  GetRegion ?getRegion;
  bool  boolRegion= false;
  void getDataRegion({required int idCity}){
    boolRegion = false;
    DioHelper.postData(url: "getregionsbycity",data: {
      "id_city":idcity,
    } ,token: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbG9jYXRpb25zdG9yLmNvbVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY1MTM4NDk1NywibmJmIjoxNjUxMzg0OTU3LCJqdGkiOiJ4MWl1YzNTc0FLNWRqdmJPIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.qm0w6xxfOtp8l2A4l07JkVV_MiCuwZELDDGQUh6sTrA").
    then((value) {
       print(value.data);
      getRegion = GetRegion.fromJson(value.data);
      boolRegion =true;
      print(getRegion.toString());
      emit(AppScuessGetRegion());
    }).catchError((onError){
      print(onError.toString());
       boolRegion = false;
      emit(AppErrorGetRegion());
    });
  }


//////  image Picker ///////

  File? image;
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> openImagePicker() async {
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
        image = File(pickedImage.path);
       print(pickedImage.path.split('/').last);
       print(pickedImage.path);
    }
    print(image!.path);
    emit(AppImagePicker());
  }

  void userRegister({required FormData formData}){
    emit(AppUserWattingRegister());
    DioHelper.postDataFormat(url: "auth/register",
        token : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODA4MVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY1MTAzMzY2NSwibmJmIjoxNjUxMDMzNjY1LCJqdGkiOiJJOHVVQ3BzZjl5eG1weW1rIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.yGtyvjr74BJm3v0MPI75fXeOqH_ZpEM_UzZkMkNM5bg",data: formData).then((value) {
      print(value.toString());
      print("Scu---------------------");
      print(value.data);
      emit(AppUserScuessRegister());
    }).catchError((onError){
      print("er---------------------");
      print(onError.toString());
      emit(AppUserErrorRegister());
    });
  }

////////////////////////////

City ?city;
Regions ?regions;
}
enum changeGender {male , female}
enum language {ar, en}
enum themeLight {dark, light}

abstract class RegisterStates {}
class AppInitRegisterState extends RegisterStates{}
class ShopChangePasswordVisibilityState extends RegisterStates{}
class AppUserWattingRegister extends RegisterStates {}
class AppUserScuessRegister extends RegisterStates {}
class AppUserErrorRegister extends RegisterStates {}
class ChangeGenderState extends RegisterStates{}
class AppSCUSESSXGetCity extends RegisterStates {}
class AppWattingGetCity extends RegisterStates {}
class AppErrorGetCity extends RegisterStates {}
class AppScuessGetRegion extends RegisterStates {}
class AppWattingGetRegion extends RegisterStates {}
class AppErrorGetRegion extends RegisterStates {}
class AppChangeRegion extends RegisterStates {}
class AppImagePicker extends RegisterStates {}
class AppGetPhone extends RegisterStates {}