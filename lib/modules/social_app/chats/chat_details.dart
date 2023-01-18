import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_models/message.dart';
import 'package:social_app/models/social_models/users.dart';
import 'package:social_app/styles/colors.dart';
import 'package:social_app/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel? socialUserModel;
  ChatDetailsScreen({
    this.socialUserModel,
  });
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        SocialAppCubit.get(context).getMessages(receiverId: socialUserModel!.uId!);
        return BlocConsumer<SocialAppCubit, SocialAppStates>(
          listener: (context, state) {},
          builder:  (context, state) {
            var cubit = SocialAppCubit.get(context).messages;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                ),
                titleSpacing: 0,
                title: Row(
                  children:  [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          '${socialUserModel!.image}'
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${socialUserModel!.name}',
                    ),
                  ],
                ),
              ),
              body:  Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message = cubit[index];
                            if(SocialAppCubit.get(context).socialUserModel!.uId! == message.senderId) {
                              return buildMyMessage(message);
                            }
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 7,
                          ),
                          itemCount: cubit.length
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,

                          ),
                          borderRadius: BorderRadius.circular(20),

                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller:messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type here ...',
                                ),
                              ),
                            ),
                            Container(
                              color: defaultColor,
                              child: MaterialButton(
                                height: 60,
                                onPressed: (){
                                  SocialAppCubit.get(context).sendMessage(
                                      receiverId: socialUserModel!.uId!,
                                      text: messageController.text,
                                      dateTime: DateTime.now().toString()
                                  );
                                  messageController.text = '';
                                },
                                minWidth: 1,
                                child: const Icon(
                                  IconBroken.Send,
                                  size: 16,
                                  color: Colors.white,

                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

        );
      },
    );
  }


  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration:  BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
        color: Colors.blueGrey[800],

      ),
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child: Text(
        '${model.text}',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration:  BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
        color: defaultColor.withOpacity(0.3),

      ),
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child: Text(
        '${model.text}',
        style: TextStyle(
          color: Colors.blueGrey[900],
        ),
      ),
    ),
  );
}
