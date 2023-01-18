import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/styles/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfileScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialAppCubit.get(context).socialUserModel;
        var profileImage = SocialAppCubit.get(context).profileImage;
        var coverImage = SocialAppCubit.get(context).coverImage;
        dynamic profilePic;
        dynamic coverPic;

        if(profileImage == null)
        {
          profilePic= NetworkImage(
              '${model!.image}'
          );
        } else{
          profilePic = FileImage(profileImage);
        }

        if(coverImage == null)
        {
          coverPic= NetworkImage(
              '${model!.cover}'
          );
        } else{
          coverPic = FileImage(coverImage);
        }

        nameController.text = model!.name!;
        bioController.text = model.bio!;
        phoneController.text = model.phone!;

        return Scaffold(
          appBar: defaultAppBar(context: context, title: 'Edit Profile', actions: [
            TextButton(
              onPressed: () {
                SocialAppCubit.get(context).updateUserData(
                    bio: bioController.text,
                    phone: phoneController.text,
                    name: nameController.text
                );
              },
              child: const Text('Update'),
            ),
            const SizedBox(
              width: 10,
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is SocialAppUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160,
                                width: double.infinity,
                                decoration:  BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      topLeft: Radius.circular(5),
                                    ),
                                    image: DecorationImage(
                                      image: coverPic,
                                      fit: BoxFit.cover,

                                    )
                                ),
                              ),
                              IconButton(

                                  onPressed: (){
                                    SocialAppCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: profilePic,
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  SocialAppCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if(SocialAppCubit.get(context).profileImage != null || SocialAppCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if(SocialAppCubit.get(context).profileImage != null)
                          Expanded(
                          child: defaultButton(
                            text: 'update profile',
                            function: (){
                              SocialAppCubit.get(context).uploadProfileImage(
                                  bio: bioController.text,
                                  phone: phoneController.text,
                                  name: nameController.text
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if(SocialAppCubit.get(context).coverImage != null)
                          Expanded(
                          child: defaultButton(
                            text: 'update cover',
                            function: (){
                              SocialAppCubit.get(context).uploadCoverImage(
                                  bio: bioController.text,
                                  phone: phoneController.text,
                                  name: nameController.text
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      text: 'Name',
                      validate: (value){
                        if(value!.isEmpty)
                        {
                          return 'Name Must Not Be Empty ';
                        }
                        return null;
                        },
                      prefixIcon: IconBroken.User
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      text: 'Bio',
                      validate: (value){
                        if(value!.isEmpty)
                        {
                          return 'Bio Must Not Be Empty ';
                        }
                        return null;
                      },
                      prefixIcon: IconBroken.Info_Circle
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value){
                      if(value!.isEmpty)
                      {
                        return 'Phone Must Not Be Empty ';
                      }
                      return null;
                      },
                    text: 'Phone',
                    prefixIcon: IconBroken.Call,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        );
      },
    );
  }
}

