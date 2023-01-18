import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_models/post.dart';
import 'package:social_app/styles/colors.dart';
import 'package:social_app/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context).postModel;

        return ConditionalBuilder(
          condition: cubit!.length > 0 && SocialAppCubit.get(context).socialUserModel != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      const Image(
                        image: NetworkImage(
                          'https://image.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg',
                        ),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top:30,start: 5),
                        child: Column(
                          children: const [
                            Text(
                              'communicate',
                              style: TextStyle(
                                  color: Colors.black
                              ),

                            ),
                            Text(
                              'with',
                              style: TextStyle(
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              'friends ..',
                              style: TextStyle(
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder:  (context, index) => const SizedBox(height: 10,),
                    itemBuilder: (context, index) => buildPostItem(cubit[index],index ,context),
                    itemCount: cubit.length
                ),
                const SizedBox(height: 10,)
              ],
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },


    );
  }

  Widget buildPostItem(PostModel model, index, context ) =>  Card(
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  '${model.image}'
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                            '${model.name}',
                          style: TextStyle(
                              height: 1.4
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: defaultColor,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              IconButton(
                  onPressed: (){},
                  icon: const Icon(
                      IconBroken.More_Circle
                  )
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 1,

            ),

          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),

          // Padding(
          //   padding: const EdgeInsets.only(top: 5,bottom: 5),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height:20,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: const Text(
          //                 '#software',
          //                 style: TextStyle(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height:20,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: const Text(
          //                 '#flutter',
          //                 style: TextStyle(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height:20,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: const Text(
          //                 '#dart',
          //                 style: TextStyle(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height:20,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: const Text(
          //                 '#software_development',
          //                 style: TextStyle(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
            Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image:  DecorationImage(
                    image:  NetworkImage(
                      '${model.postImage}',
                    ),
                    fit: BoxFit.cover,

                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children:  [
                          Icon(
                            IconBroken.Heart,
                            size: 20,
                            color: Colors.redAccent,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            '${SocialAppCubit.get(context).totalLikes![index]}',
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      SocialAppCubit.get(context).likePost(
                          postId: SocialAppCubit.get(context).postId![index]
                      );
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            IconBroken.Message,
                            size: 20,
                            color: Colors.amberAccent,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            '0',
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 1,

            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(

                  child: Row(
                    children: [
                       CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          '${SocialAppCubit.get(context).socialUserModel!.image}',
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(width: 15),

                    ],
                  ),
                  onTap: (){},
                ),
              ),
              Row(
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children:  [
                          const Icon(
                            IconBroken.Heart,
                            size: 20,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


