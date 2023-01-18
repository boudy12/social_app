abstract class SocialAppStates{}

class SocialAppInitialState extends SocialAppStates{}
// ---------------- get user ----------------------------------
class SocialAppGetUserLoadingState extends SocialAppStates{}

class SocialAppGetUserSuccessState extends SocialAppStates{}

class SocialAppGetUserErrorState extends SocialAppStates{
  final String error;

  SocialAppGetUserErrorState(this.error);
}

class SocialAppNewPostState extends SocialAppStates{}


class SocialAppChangeBottomNavBarState extends SocialAppStates{}


class SocialAppProfileImagePickedSuccessState extends SocialAppStates{}

class SocialAppProfileImagePickedErrorState extends SocialAppStates{}

class SocialAppCoverImagePickedSuccessState extends SocialAppStates{}

class SocialAppCoverImagePickedErrorState extends SocialAppStates{}


class SocialAppUploadProfileImageSuccessState extends SocialAppStates{}

class SocialAppUploadProfileImageErrorState extends SocialAppStates{}


class SocialAppUploadCoverImageSuccessState extends SocialAppStates{}

class SocialAppUploadCoverImageErrorState extends SocialAppStates{}

class SocialAppUserUpdateLoadingState extends SocialAppStates{}

class SocialAppUserUpdateErrorState extends SocialAppStates{}





//---------------- create post ------------------------------

class SocialAppCreatePostLoadingState extends SocialAppStates{}

class SocialAppCreatePostSuccessState extends SocialAppStates{}

class SocialAppCreatePostErrorState extends SocialAppStates{}

class SocialAppPostImagePickedSuccessState extends SocialAppStates{}

class SocialAppPostImagePickedErrorState extends SocialAppStates{}

class SocialAppRemovePostImageState extends SocialAppStates{}


// ------------------- get posts -------------------------------
class SocialAppGetPostsLoadingState extends SocialAppStates{}

class SocialAppGetPostsSuccessState extends SocialAppStates{}

class SocialAppGetPostsErrorState extends SocialAppStates{
  final String error;

  SocialAppGetPostsErrorState(this.error);
}

// ------------------- posts Likes -------------------------------

class SocialAppLikePostsSuccessState extends SocialAppStates{}

class SocialAppLikePostsErrorState extends SocialAppStates{
  final String error;

  SocialAppLikePostsErrorState(this.error);
}

// ------------------- all users -------------------------------
class SocialAppGetAllUserLoadingState extends SocialAppStates{}

class SocialAppGetAllUserSuccessState extends SocialAppStates{}

class SocialAppGetAllUserErrorState extends SocialAppStates{
  final String error;

  SocialAppGetAllUserErrorState(this.error);
}

// ------------------- message -------------------------------

class SocialAppGetMessagesSuccessState extends SocialAppStates{}

class SocialAppGetMessagesErrorState extends SocialAppStates{}

class SocialAppSendMessageSuccessState extends SocialAppStates{}

class SocialAppSendMessageErrorState extends SocialAppStates{}


