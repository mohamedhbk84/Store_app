import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/BottomNavCubit/bottomNavCubit.dart';
import 'package:store/view/splach/splach.dart';
class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>BottomNavCubit(),
    child: BlocConsumer<BottomNavCubit,BottomNavStates>(
    listener: (context, states) => {},
    builder: (context, states) {
      var cubit= BottomNavCubit.get(context);
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              cubit.changeBottomNav(value);
            },
            currentIndex: cubit.currenindex,
            items: cubit.bottomItem),
        body: cubit.screen[cubit.currenindex],
      );})

    );
  }
}
