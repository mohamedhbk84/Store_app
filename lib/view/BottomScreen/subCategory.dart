import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/BottomScreenCubit/CategoryCubit.dart';
import 'package:store/model/CategoryModeel.dart';
import 'package:store/model/SubCategoryModel.dart';
import 'package:store/shared/component/component.dart';
class SubCategory extends StatelessWidget {
   final int id ;
   SubCategory({Key? key, required this.id}) : super(key: key);
   var searchController = TextEditingController();

   @override
   Widget build(BuildContext context) {
     return BlocProvider(create: (BuildContext context)=> CategoryCubit()..getSlider()..getsubCategory(id: id),
     child: BlocConsumer<CategoryCubit,CategoryStates>(
       listener: (context, state) {
       },
       builder: (context,state){
         var cubit = CategoryCubit.get(context);
         if(cubit.check) {
           return SafeArea(
             child: Scaffold(
               body: Column(children: [

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
                 // CarouselSlider(
                 //   items: model.data.banners
                 //       .map((e) => Image(
                 //     image: NetworkImage('${e.image}'),
                 //     width: double.infinity,
                 //     fit: BoxFit.cover,
                 //   ))
                 //       .toList(),
                 //   options: CarouselOptions(
                 //     height: 200,
                 //     initialPage: 0,
                 //     enableInfiniteScroll: true,
                 //     reverse: false,
                 //     autoPlay: true,
                 //     autoPlayInterval: Duration(seconds: 3),
                 //     autoPlayAnimationDuration: Duration(seconds: 1),
                 //     scrollDirection: Axis.horizontal,
                 //     autoPlayCurve: Curves.fastOutSlowIn,
                 //     viewportFraction: 1,
                 //   ),
                 // ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: CarouselSlider(
                     items: cubit.sliderModel!.slider
                         .map((e) =>
                         Image(
                           image: NetworkImage(e.image),
                               //'https://img.freepik.com/free-psd/hand-holding-smartphone-connect-bluetooth-speaker_53876-115875.jpg?size=338&ext=jpg'),
                           width: double.infinity,
                           fit: BoxFit.cover,
                         ))
                         .toList(),
                     options: CarouselOptions(
                       height: 140,
                       initialPage: 0,
                       enableInfiniteScroll: true,
                       reverse: false,
                       autoPlay: true,
                       autoPlayInterval: Duration(seconds: 3),
                       autoPlayAnimationDuration: Duration(seconds: 1),
                       scrollDirection: Axis.horizontal,
                       autoPlayCurve: Curves.fastOutSlowIn,
                       viewportFraction: 1,
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 10,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: const [
                     Padding(
                       padding: EdgeInsets.only(left: 8.0,
                           right: 8.0,
                           top: 2,
                           bottom: 6),
                       child: Text("الاقسام الفرعية او المتجار"),
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
                     children: List.generate(cubit.subCategoriesModel!.sub.length, (index) =>
                         Padding(
                           padding: EdgeInsets.only(left: 4,right: 4),
                           child: Card(
                             elevation: 7,
                             child: Container(
                               // color: Colors.white,
                               height: 135,
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
                                                       image: DecorationImage(image: NetworkImage(
                                                         cubit.subCategoriesModel!.sub[index].image != null
                                                             ? cubit.subCategoriesModel!.sub[index].image : "https://image.freepik.com/free-psd/hand-holding-smartphone-connect-bluetooth-speaker_53876-115875.jpg",),fit: BoxFit.fill)),
                                                 ),
                                               ),
                                               Row(
                                                 children: [
                                                   IconButton(
                                                     onPressed: () {
                                                       cubit.getfavourite(cubit.subCategoriesModel!.sub[index], context);
                                                     },
                                                     iconSize: 12,
                                                     icon: CircleAvatar(
                                                       backgroundColor:
                                                       Colors.grey.shade300.withOpacity(.9),
                                                       child: Icon(
                                                         Icons.favorite,
                                                         color:cubit.color ,
                                                       ),
                                                     ),
                                                   ),
                                                   Spacer(),
                                                   Icon(
                                                     Icons.star,
                                                     color: Colors.yellow,
                                                   ),
                                                 ],
                                               ),


                                             ],
                                           ),
                                           Padding(
                                             padding: EdgeInsets.all(0),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               children: [
                                                 Center(
                                                   child: Padding(
                                                     padding: const EdgeInsets.all(5),
                                                     child: Text(
                                                       cubit.subCategoriesModel!.sub[index].name,
                                                       maxLines: 2,
                                                       overflow: TextOverflow.ellipsis,
                                                       style: TextStyle(
                                                         fontSize: 16.0,
                                                         height: 1.1,
                                                       ),
                                                     ),
                                                   ),
                                                 ),

                                                 // Row(
                                                 //   children: [
                                                 //     Text(
                                                 //       "LE 3000",
                                                 //     ),
                                                 //     Spacer(),
                                                 //     Container(
                                                 //       width: 60,
                                                 //       height: 30,
                                                 //       decoration: BoxDecoration(
                                                 //           borderRadius: BorderRadius.only(
                                                 //               topLeft: Radius.circular(20))),
                                                 //       child: Center(
                                                 //         child: Text(
                                                 //           "+Add ",
                                                 //         ),
                                                 //       ),
                                                 //     )
                                                 //   ],
                                                 // ),
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
                         )),
                         // featuredItem(
                         //     context, cubit.subCategoriesModel, index,  CategoryCubit)),
                   ),
                 ),
               ],),
             ),
           );
         }else {
           return Scaffold(body:
             Center(child: CircularProgressIndicator(),)
         );

         }
       },
     ),
     );

   }

   // Widget featuredItem(context,SubCategoriesModel ?categoriesModel , index,  CategoryCubit) =>
   //     Padding(
   //   padding: EdgeInsets.only(left: 4,right: 4),
   //   child: Card(
   //     elevation: 7,
   //     child: Container(
   //       // color: Colors.white,
   //       height: 135,
   //       child: Column(
   //         crossAxisAlignment: CrossAxisAlignment.start,
   //         children: [
   //           Stack(
   //             alignment: AlignmentDirectional.bottomStart,
   //             children: [
   //               Column(
   //                 children: [
   //                   Stack(
   //                     alignment: Alignment.topRight,
   //                     children: [
   //                       Center(
   //                         child: Container(
   //                           margin: EdgeInsets.only(top: 10),
   //                           height: 128,
   //                           width: 135,
   //
   //                           decoration: BoxDecoration(
   //
   //                               borderRadius: BorderRadius.circular(80),
   //                               image: DecorationImage(image: NetworkImage(
   //                                 categoriesModel!.sub[index].image != null
   //                                 ? categoriesModel.sub[index].image : "https://image.freepik.com/free-psd/hand-holding-smartphone-connect-bluetooth-speaker_53876-115875.jpg",),fit: BoxFit.fill)),
   //                         ),
   //                       ),
   //                       Row(
   //                         children: [
   //                           IconButton(
   //                             onPressed: () {
   //                               cubit
   //                             },
   //                             iconSize: 12,
   //                             icon: CircleAvatar(
   //                               backgroundColor:
   //                               Colors.grey.shade300.withOpacity(.9),
   //                               child: Icon(
   //                                 Icons.favorite,
   //                                 color:cubit.color ,
   //                               ),
   //                             ),
   //                           ),
   //                           Spacer(),
   //                           Icon(
   //                             Icons.star,
   //                             color: Colors.yellow,
   //                           ),
   //                         ],
   //                       ),
   //
   //
   //                     ],
   //                   ),
   //                   Padding(
   //                     padding: EdgeInsets.all(0),
   //                     child: Column(
   //                       crossAxisAlignment: CrossAxisAlignment.start,
   //                       mainAxisAlignment: MainAxisAlignment.start,
   //                       children: [
   //                         Center(
   //                           child: Padding(
   //                             padding: const EdgeInsets.all(5),
   //                             child: Text(
   //                               categoriesModel.sub[index].name,
   //                               maxLines: 2,
   //                               overflow: TextOverflow.ellipsis,
   //                               style: TextStyle(
   //                                 fontSize: 16.0,
   //                                 height: 1.1,
   //                               ),
   //                             ),
   //                           ),
   //                         ),
   //
   //                         // Row(
   //                         //   children: [
   //                         //     Text(
   //                         //       "LE 3000",
   //                         //     ),
   //                         //     Spacer(),
   //                         //     Container(
   //                         //       width: 60,
   //                         //       height: 30,
   //                         //       decoration: BoxDecoration(
   //                         //           borderRadius: BorderRadius.only(
   //                         //               topLeft: Radius.circular(20))),
   //                         //       child: Center(
   //                         //         child: Text(
   //                         //           "+Add ",
   //                         //         ),
   //                         //       ),
   //                         //     )
   //                         //   ],
   //                         // ),
   //                       ],
   //                     ),
   //                   )
   //                 ],
   //               ),
   //             ],
   //           ),
   //         ],
   //       ),
   //     ),
   //   ),
   // );
}
