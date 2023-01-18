import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_models/users.dart';
import 'package:social_app/modules/social_app/chats/chat_details.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context).allUsers;
        return ConditionalBuilder(
          condition: cubit.length > 0,
          builder: (context) =>  ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(cubit[index], context),
              separatorBuilder: (context, index) => buildSpacerLine(),
              itemCount: cubit.length
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildChatItem(SocialUserModel model, context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(
        socialUserModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              '${model.image}'
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
                '${model.name}',
              style: TextStyle(
                  height: 1.4
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
