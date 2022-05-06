import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/splach_cubit/SplachCubit.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return BlocProvider(
        create: (BuildContext context) => splachCubit()..getData()..firstStart(context),
        child: BlocConsumer<splachCubit, splachStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit= splachCubit.get(context);
              return Scaffold(
                backgroundColor: lightMode
                    ? const Color(0xffffffff)
                    : const Color(0xffffffff),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                          child:Image.network(cubit.imageUrl ?? "https://locationstor.com/assets/images/images.jpeg")

                    ),),

                    const  Text("Welcome Matager"),
                  ],
                ),
              );
            }));
  }
}
