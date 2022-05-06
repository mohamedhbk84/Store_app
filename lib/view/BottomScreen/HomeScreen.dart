import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/BottomScreenCubit/CategoryCubit.dart';
import 'package:store/model/CategoryModeel.dart';
import 'package:store/shared/component/component.dart';
import 'package:store/shared/component/utils.dart';
import 'package:store/view/BottomScreen/subCategory.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CategoryCubit()..getCategory(),
      child: BlocConsumer<CategoryCubit, CategoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CategoryCubit.get(context);
          if (cubit.check) {
            return SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: defaultFormField(
                          controller: searchController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'اكتب البحث';
                            } else {
                              return null;
                            }
                          },
                          onChange: (value) {},
                          label: 'Write Would Like To Search You',
                          prefix: Icons.search,
                          onTap: () {
                            print('phone taped');
                          }),
                    ),
                    Divider(),
                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                          itemCount: 8,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 100,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 95,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo,
                                          borderRadius:
                                              BorderRadius.circular(70)),
                                    ),
                                    const Text(
                                      "nnn",
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 2, bottom: 6),
                          child: Text("الاقسام"),
                        ),
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 1 / 1.1,
                        children: List.generate(
                            cubit.categoriesModel!.categories.length,
                            (index) => featuredItem(
                                context, cubit.categoriesModel, index)),
                      ),
                    ),
                  ],
                ),
              ),
            );
            // }else if(cubit.categoriesModel!.categories.length == 0){
            //
            //   return SafeArea(child: Scaffold(
            //     body: Column(children: [
            //         Center(child: Text("No Data Found"),),
            //     ],),
            //       ));

          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget featuredItem(context, CategoriesModel? categoriesModel, index) =>
      Padding(
        padding: EdgeInsets.only(left: 4, right: 4),
        child: Card(
          elevation: 7,
          child: GestureDetector(
            onTap: () {
              navigateTo(
                  context,
                  SubCategory(
                    id: categoriesModel!.categories[index].id,
                  ));
            },
            child: Container(
              // color: Colors.white,
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: 128,
                                  width: 135,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            categoriesModel!.categories[index]
                                                        .image !=
                                                    null
                                                ? categoriesModel
                                                    .categories[index].image
                                                : "https://image.freepik.com/free-psd/hand-holding-smartphone-connect-bluetooth-speaker_53876-115875.jpg",
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    categoriesModel.categories[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      height: 1.1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
