import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/social_app/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/styles/icon_broken.dart';

class SocialAppLayoutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context, state) {
        if(state is SocialAppNewPostState)
          {
            navigateTo(context, NewPost());
          }
      },
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    IconBroken.Notification,
                  )
              ),
              IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    IconBroken.Search,
                  )
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottom(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },

    );
  }
}
