import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/BottomScreenCubit/ProfileCubit.dart';
import 'package:store/model/CategoryModeel.dart';
import 'package:store/model/SliderModel.dart';
import 'package:store/model/SubCategoryModel.dart';
import 'package:store/shared/component/utils.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

class CategoryCubit extends Cubit <CategoryStates>{
  CategoryCubit():super(AppCategoryStates());
static CategoryCubit get(context)=>BlocProvider.of(context);
  CategoriesModel ? categoriesModel;
  bool check = false;
  Color  color =Colors.white;
void getCategory(){
  check = false;
  DioHelper.getData(url: "getcategories" , token: Utils.getToken()).then((value) {
    categoriesModel = CategoriesModel.fromJson(value.data);
    print(categoriesModel);
    emit(AppScuessCategoryState());
    check = true;
  }).catchError((onError){
   print(onError.toString());
   check = false;
   emit(AppErrorCategoryState());
  });
}
  SubCategoriesModel ?subCategoriesModel;
void getsubCategory({required int id}){
  check = false;
  DioHelper.postData(url: "getsubcategories",
      token:Utils.getToken(), data: {
    "id":id
      }).then((value) {
  print(value.data);
  subCategoriesModel = SubCategoriesModel.fromJson(value.data);
  print(subCategoriesModel);
  check = true;
  emit(AppScuessSubCategory());
  }).catchError((onError){
   print(onError.toString());
   check = false;
   emit(AppErrorSubCategory());

  });
}


void getfavourite(sub, context){
  if(color ==Colors.white){
    color = Colors.red;
BlocProvider.of<ProfileCubit>(context).favouriteList.add(sub!);
  } else {
    color = Colors.white;
    BlocProvider.of<ProfileCubit>(context).favouriteList.remove(sub);
  }
  print("new List ${BlocProvider.of<ProfileCubit>(context).favouriteList}");
  emit(AppFavouriteCategory());
}
SliderModel? sliderModel;
void getSlider(){
  DioHelper.getData(url: "slider",token: Utils.getToken() , ).then((value) {
    print(value.toString());
    sliderModel = SliderModel.fromJson(value.data);
    emit(AppScuessSliderCategory());
  }).catchError((onError){
    print(onError.toString());
    emit(AppErrorSliderCategory());
  });
}
}

abstract class CategoryStates{}
class AppCategoryStates extends CategoryStates {}
class AppScuessCategoryState extends CategoryStates {}
class AppErrorCategoryState extends CategoryStates {}
class AppScuessSubCategory  extends CategoryStates {}
class AppErrorSubCategory  extends CategoryStates {}
class AppFavouriteCategory  extends CategoryStates {}
class AppScuessSliderCategory  extends CategoryStates {}
class AppErrorSliderCategory  extends CategoryStates {}