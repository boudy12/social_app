import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/styles/colors.dart';
import 'package:social_app/styles/icon_broken.dart';

class NewPost extends StatelessWidget {

  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialAppCubit
            .get(context)
            .socialUserModel;
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                TextButton(
                  onPressed: () {
                    if (SocialAppCubit
                        .get(context)
                        .postImage == null) {
                      SocialAppCubit.get(context).createPost(
                          text: postController.text,
                          dateTime: DateTime.now().toString()
                      );
                    } else {
                      SocialAppCubit.get(context).createPost(
                          text: postController.text,
                          dateTime: DateTime.now().toString()
                      );
                    }
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),

                ),
                const SizedBox(
                  width: 10,
                ),
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                if(state is SocialAppCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if(state is SocialAppCreatePostLoadingState)
                  const SizedBox(height: 10,),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg'
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${cubit!.name}',
                            style: const TextStyle(
                                height: 1.4
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'public',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),

                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: const InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                if(SocialAppCubit
                    .get(context)
                    .postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: FileImage(SocialAppCubit
                                  .get(context)
                                  .postImage!),
                              fit: BoxFit.cover,

                            )
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialAppCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.close_rounded,
                              size: 18,
                            ),
                          )
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialAppCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                  'add photo'
                              ),
                            ],
                          )
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                            'tags'
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
