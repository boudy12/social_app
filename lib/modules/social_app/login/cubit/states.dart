
abstract class SocialAppLoginStates{}

class SocialAppLoginInitialState extends SocialAppLoginStates{}

class SocialAppLoginLoadingState extends SocialAppLoginStates{}

class SocialAppLoginSuccessState extends SocialAppLoginStates{
  final String uId;

  SocialAppLoginSuccessState(this.uId);

}

class SocialAppLoginErrorState extends SocialAppLoginStates{
  final String error;
  SocialAppLoginErrorState(this.error);
}

class SocialAppLoginShowPasswordState extends SocialAppLoginStates{}
