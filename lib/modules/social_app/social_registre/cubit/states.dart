
abstract class SocialRegistreStates {}

class SocialRegistreInitialState extends SocialRegistreStates {}

class SocialRegistreLoadingState extends SocialRegistreStates {}

class SocialRegistreSuccessState extends SocialRegistreStates {}

class SocialRegistreErrorState extends SocialRegistreStates {
  final String error;

  SocialRegistreErrorState(this.error);
}

class SocialCreateUserSuccessState extends SocialRegistreStates {}

class SocialCreateUserErrorState extends SocialRegistreStates {
  final String error;

  SocialCreateUserErrorState(this.error);

}

class SocialChangePasswordVisiblityState extends SocialRegistreStates {}
