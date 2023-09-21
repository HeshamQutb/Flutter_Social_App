

abstract class ProfileStates {}


class ProfileInitialState extends ProfileStates{}

class GetProfileLoadingState extends ProfileStates{}

class GetProfileSuccessState extends ProfileStates{

}

class GetProfileErrorState extends ProfileStates{
  final String error;

  GetProfileErrorState(this.error);
}

class GetProfileImageSuccessState extends ProfileStates{

}

class GetProfileImageErrorState extends ProfileStates{

}

class GetCoverImageSuccessState extends ProfileStates{

}

class GetCoverImageErrorState extends ProfileStates{

}


