import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_models/message.dart';
import 'package:social_app/models/social_models/post.dart';
import 'package:social_app/models/social_models/users.dart';
import 'package:social_app/modules/social_app/chats/chats_screen.dart';
import 'package:social_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:social_app/modules/social_app/login/cubit/states.dart';
import 'package:social_app/modules/social_app/new_post/new_post_screen.dart';
import 'package:social_app/modules/social_app/setting/setting_screen.dart';
import 'package:social_app/modules/social_app/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/styles/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialAppCubit extends Cubit<SocialAppStates>{

  SocialAppCubit() : super(SocialAppInitialState());

  static SocialAppCubit get(context)=> BlocProvider.of(context);

  SocialUserModel? socialUserModel;

  void getUserData(){
    emit(SocialAppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      socialUserModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialAppGetUserSuccessState());
    }).catchError((error){
      emit(SocialAppGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPost(),
    UsersScreen(),
    SettingScreen(),
  ];

  List<String> titles = [
    'News Feed',
    'Chats',
    'Posts',
    'Users',
    'Setting',
  ];

  List<BottomNavigationBarItem> bottomItems =[
    const BottomNavigationBarItem(
      icon: Icon(
          IconBroken.Home
      ),
      label: 'Home'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
          IconBroken.Chat
      ),
      label: 'Chats'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
          IconBroken.Paper_Upload
      ),
      label: 'Post'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
          IconBroken.Location
      ),
      label: 'Users'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
          IconBroken.Setting
      ),
      label: 'Setting'
    ),
  ];
  
  void changeBottom(int index){
    if(index == 1)
      getAllUsers();
    if(index == 2)
      {
        emit(SocialAppNewPostState());
      }else{
      currentIndex = index;
      emit(SocialAppChangeBottomNavBarState());

    }
  }

   File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(SocialAppProfileImagePickedSuccessState());
    }else{
      print("no image selected");
      emit(SocialAppProfileImagePickedErrorState());
    }

  }

  void uploadProfileImage({
    required String bio,
    required String phone,
    required String name,
  }){
    emit(SocialAppUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
        'users/${Uri.file(profileImage!.path).pathSegments.last}'
    ).putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL().then((value) {
            updateUserData(
              bio: bio,
              phone: phone,
              name: name,
              image: value,
            );
     //       emit(SocialAppUploadProfileImageSuccessState());
          }).catchError((error){
            emit(SocialAppUploadProfileImageErrorState());
          });
    })
        .catchError((error){
      emit(SocialAppUploadProfileImageErrorState());
    });
  }

  File? coverImage;
  Future<void> getCoverImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      coverImage = File(pickedFile.path);
      emit(SocialAppCoverImagePickedSuccessState());
    }else{
      print("no image selected");
      emit(SocialAppCoverImagePickedErrorState());
    }

  }

  void uploadCoverImage({
    required String bio,
    required String phone,
    required String name,
  }){
    emit(SocialAppUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
        'users/${Uri.file(coverImage!.path).pathSegments.last}'
    ).putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          bio: bio,
          phone: phone,
          name: name,
          cover: value,
        );
   //     emit(SocialAppUploadCoverImageSuccessState());
      }).catchError((error){
        emit(SocialAppUploadCoverImageErrorState());
      });
    })
        .catchError((error){
      emit(SocialAppUploadProfileImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String bio,
  //   required String phone,
  //   required String name,
  // }){
  //   emit(SocialAppUserUpdateLoadingState());
  //   if(coverImage != null)
  //     {
  //       getCoverImage();
  //     }
  //   else if(profileImage != null)
  //     {
  //       getProfileImage();
  //     }
  //   else if(coverImage != null && profileImage != null)
  //   {
  //
  //   }
  //   else{
  //     updateUserData(
  //       phone: phone,
  //       name: name,
  //       bio: bio
  //     );
  //   }
  //
  // }

  void updateUserData({
    required String bio,
    required String phone,
    required String name,
    String? image,
    String? cover,

  }){
    SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      bio: bio,
      isEmailVerified: false,
      image: image??socialUserModel!.image,
      email: socialUserModel!.email,
      uId: socialUserModel!.uId,
      cover: cover??socialUserModel!.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(socialUserModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();

    }).catchError((error){
      emit(SocialAppUserUpdateErrorState());
    });
  }


  File? postImage;
  Future<void> getPostImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      postImage = File(pickedFile.path);
      emit(SocialAppPostImagePickedSuccessState());
    }else{
      print("no image selected");
      emit(SocialAppPostImagePickedErrorState());
    }

  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }){
    emit(SocialAppCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
        'posts/${Uri.file(postImage!.path).pathSegments.last}'
    ).putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value
        );
      }).catchError((error){
        emit(SocialAppCreatePostErrorState());
      });
    })
        .catchError((error){
      emit(SocialAppCreatePostErrorState());
    });
  }

  void removePostImage(){
    postImage = null;
    emit(SocialAppRemovePostImageState());
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,

  }){
    emit(SocialAppCreatePostLoadingState());

    PostModel postModel= PostModel(
      name: socialUserModel!.name,
      uId: socialUserModel!.uId,
      image: socialUserModel!.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
          emit(SocialAppCreatePostSuccessState());
    }).catchError((error){
      emit(SocialAppCreatePostErrorState());
    });
  }


  List<PostModel>? postModel = [];
  List<String>? postId = [];
  List<int>? totalLikes = [];

  void getPosts() {
    emit(SocialAppGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value)  {
          value.docs.forEach((element) {
            element.reference
            .collection('likes')
            .get()
            .then((value) {
              totalLikes!.add(value.docs.length);
              postId!.add(element.id);
              postModel!.add(PostModel.fromJson(element.data()));

            }).catchError((error){

            });

            });

          emit(SocialAppGetPostsSuccessState());
        }).catchError((error){
          emit(SocialAppGetPostsErrorState(error.toString()));
    });
  }

  void likePost({required String postId}){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(socialUserModel!.uId)
        .set({
      'like': true
        })
        .then((value) {
          emit(SocialAppLikePostsSuccessState());
        }).catchError((error){
          emit(SocialAppLikePostsErrorState(error.toString()));
    });

  }


  List<SocialUserModel> allUsers = [];

  void getAllUsers(){
    allUsers = [];
    emit(SocialAppGetAllUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value)  {
      value.docs.forEach((element) {
         if(element.id != socialUserModel!.uId) {
          allUsers.add(SocialUserModel.fromJson(element.data()));
        }
      });
      emit(SocialAppGetAllUserSuccessState());
    }).catchError((error){
      emit(SocialAppGetAllUserErrorState(error.toString()));
      print(error.toString());
    });
  }

  void sendMessage({
  required String receiverId,
  required String text,
  required String dateTime,
}){
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: socialUserModel!.uId,
    );
    //set my chat
    FirebaseFirestore.instance
        .collection('users')
    .doc(socialUserModel!.uId) // me
    .collection('chats') // new  collection for chat
    .doc(receiverId) // chat doc with friend
    .collection('messages') // all chat messages with friend
    .add(model.toMap()).then((value) {
      emit(SocialAppSendMessageSuccessState());
    }).catchError((error){
      emit(SocialAppSendMessageErrorState());
    });

    //set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId) // me
        .collection('chats') // new  collection for chat
        .doc(socialUserModel!.uId) // chat doc with friend
        .collection('messages') // all chat messages with friend
        .add(model.toMap()).then((value) {
      emit(SocialAppSendMessageSuccessState());
    }).catchError((error){
      emit(SocialAppSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(socialUserModel!.uId) // me
        .collection('chats') // new  collection for chat
        .doc(receiverId) // chat doc with friend
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialAppGetMessagesSuccessState());
    });
  }
}