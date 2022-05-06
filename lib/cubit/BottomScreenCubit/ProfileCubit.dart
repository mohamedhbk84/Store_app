import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/Auth_cubit/RegisterCubit.dart';
import 'package:store/model/LoginModel.dart';
import 'package:store/model/SubCategoryModel.dart';
import 'package:store/model/getCity.dart';
import 'package:store/model/getRegion.dart';
import 'package:store/shared/component/utils.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit():super(AppInitProfileState());
  static ProfileCubit get(context)=> BlocProvider.of(context);
  language lang = language.ar;
  List <Sub> favouriteList = [];
  void first(){
    if("male".tr()=="ذكر"){
      lang = language.ar;
    }else{
      lang = language.en;
    }

emit(ChangeLanguageState());
  }
  void changeLanguage( value){
    lang = value;
    emit(ChangeLanguageState());
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(ShopChangePasswordVisibilityState());
  }

  changeGender gender = changeGender.male;
  themeLight theme = themeLight.dark;
  void changeRadio( value){
    gender = value;
    emit(ChangeGenderState());
  }
  bool isDark = true;
  void changetheme( value){
    theme = value;
    if(theme==themeLight.light){
      isDark = false;
    }else {
      isDark = true;
    }
    print(theme);
    emit(ChangeGenderState());
  }
  bool  dark = true;
  // void changeModeDark(value) {
  //   dark = value;
  //   isDark =dark;
  //   print(isDark);
  //   emit(AppChangeModeDarkStates());
  // }
  // void changeDark()
  // {
  //   isDark = dark;
  //   emit(AppChangeModeDarkStates());
  // }

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
  void changeRegion(value){
    regions= value;
    id_region =regions!.id;
    emit(AppChangeRegion());
  }

  GetRegion ?getRegion;
  bool  boolRegion= false;
  void getDataRegion({required int idCity}){
    boolRegion = false;
    DioHelper.postData(url: "getregionsbycity",data: {
      "id_city":idcity,
    } ,token: Utils.getToken()
).
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
  City ?city;
  Regions ?regions;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  void getDataShared( ) {
    dummyUser.name = CacheHelper.getData(key: "name")==null?dummyUser.name:CacheHelper.getData(key: "name");
    dummyUser.city = CacheHelper.getData(key: "city")==null?dummyUser.city:CacheHelper.getData(key: "city");
    dummyUser.city_id = CacheHelper.getData(key: "city_id")==null?dummyUser.city_id:CacheHelper.getData(key: "city_id");
    dummyUser.region = CacheHelper.getData(key: "region")==null?dummyUser.region:CacheHelper.getData(key: "region");
    dummyUser.region_id = CacheHelper.getData(key: "region_id")==null?dummyUser.region_id:CacheHelper.getData(key: "region_id");
    dummyUser.mobile = CacheHelper.getData(key: "mobile")==null?dummyUser.mobile:CacheHelper.getData(key: "mobile");
    dummyUser.gender = CacheHelper.getData(key: "gender")==null?dummyUser.gender:CacheHelper.getData(key: "gender");
    nameController.text = dummyUser.name;
    phoneController.text = dummyUser.mobile;
    passwordController.text = CacheHelper.getData(key: "password")==null?'':CacheHelper.getData(key: "password");
    passwordConfirmController.text =CacheHelper.getData(key: "password")==null?'':CacheHelper.getData(key: "password");


    DioHelper.getData(url: "getcity" ,token: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbG9jYXRpb25zdG9yLmNvbVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY1MTM4NDk1NywibmJmIjoxNjUxMzg0OTU3LCJqdGkiOiJ4MWl1YzNTc0FLNWRqdmJPIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.qm0w6xxfOtp8l2A4l07JkVV_MiCuwZELDDGQUh6sTrA").then((value) {
      getCity = GetCity.fromJson(value.data);
      print(getCity!.city.toString());
      for(int i=0;i<=getCity!.city.length; i++) {
        if (dummyUser.city == getCity!.city[i].cityName) {
          city = getCity!.city[i];
        }
      }
      emit(AppSCUSESSXGetCity());
    });
    DioHelper.postData(url: "getregionsbycity",data: {
      "id_city":dummyUser.city_id,
    } ,token: Utils.getToken()
    ).
    then((value) {
      print(value.data);
      getRegion = GetRegion.fromJson(value.data);
     for(int i=0; i<=getRegion!.regions.length;i++){
       if (dummyUser.region == getRegion!.regions[i].regionName) {
         regions =  getRegion!.regions[i];
       }
     }
      print(getRegion.toString());
      emit(AppScuessGetRegion());
    });
   // city.cityName==null? dummyUser.city:city!.cityName;
   // city.id ==null? int.parse(dummyUser.city_id):city!.id;
   // regions.regionName==null?  dummyUser.region:regions!.regionName;
   // regions.id==null? int.parse(dummyUser.region_id):regions!.id;
   emit(AppReloadSharedReferData());
  }

}
abstract class ProfileStates{}
class AppInitProfileState extends ProfileStates {}
class ChangeLanguageState extends ProfileStates {}
class ShopChangePasswordVisibilityState extends ProfileStates {}
class ChangeGenderState extends ProfileStates {}
class AppChangeModeDarkStates extends ProfileStates {}
class AppUserErrorRegister extends ProfileStates {}
// class ChangeGenderState extends ProfileStates{}
class AppSCUSESSXGetCity extends ProfileStates {}
class AppWattingGetCity extends ProfileStates {}
class AppErrorGetCity extends ProfileStates {}
class AppScuessGetRegion extends ProfileStates {}
class AppWattingGetRegion extends ProfileStates {}
class AppErrorGetRegion extends ProfileStates {}
class AppChangeRegion extends ProfileStates {}
class AppReloadSharedReferData extends ProfileStates {}