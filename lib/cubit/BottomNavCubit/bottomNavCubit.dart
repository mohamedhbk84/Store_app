import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/view/BottomScreen/FavouratesScreen.dart';
import 'package:store/view/BottomScreen/HomeScreen.dart';
import 'package:store/view/BottomScreen/ProfileScreen.dart';
import 'package:store/view/BottomScreen/StoreScreen.dart';
import 'package:store/view/BottomScreen/aboutScreen.dart';

class BottomNavCubit extends Cubit<BottomNavStates>{
  BottomNavCubit():super(AppInitBottomNavState());
  static BottomNavCubit get(context)=>BlocProvider.of(context);

  int currenindex = 0;
  List<BottomNavigationBarItem> bottomItem =const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),
    BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.map_pin_ellipse), label: "about"),
  ];

  var screen = [
    HomeScreen(),
    FavourateScreen(),
    StoreScreen(),
    ProfileScreen(),
    AboutScreen(),
  ];
  void changeBottomNav(int index) {
    currenindex = index;

    emit(AppChangeBottomNavStates());
  }
}
abstract class BottomNavStates {}
class AppInitBottomNavState extends BottomNavStates{}
class AppChangeBottomNavStates extends BottomNavStates{}
