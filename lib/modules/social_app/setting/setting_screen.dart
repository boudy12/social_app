import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/styles/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = SocialAppCubit.get(context).socialUserModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              topLeft: Radius.circular(5),
                            ),
                            image: DecorationImage(
                              image:  NetworkImage(
                                '${model!.cover}'
                              ),
                              fit: BoxFit.cover,

                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                            '${model.image}'
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                model.name!,
                style: Theme.of(context).textTheme.bodyText1,
              ),

              Text(
                model.bio!,
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '64',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Photo',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '2K',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Follower',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '506',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {

                      },
                      child: const Text(
                        'Add Photo'
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context, EditProfileScreen());
                    },
                    child: const Icon(
                      IconBroken.Edit,
                      size: 16,
                    )
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      FirebaseMessaging.instance.subscribeToTopic('announcement');
                    },
                    child: const Text(
                        'Subscribe'
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      FirebaseMessaging.instance.unsubscribeFromTopic('announcement');
                    },
                    child: const Text(
                        'unSubscribe'
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

