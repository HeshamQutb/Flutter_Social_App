abstract class SocialStates {

}

class SocialInitState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

class ChangeNavBarState extends SocialStates{}

class SocialGetProfileImageSuccessState extends SocialStates{}

class SocialGetProfileImageErrorState extends SocialStates{}

class SocialGetCoverImageSuccessState extends SocialStates{}

class SocialGetCoverImageErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}

// create post

class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialGetPostImageSuccessState extends SocialStates{}

class SocialGetPostImageErrorState extends SocialStates{}

class SocialRemovePostImageSuccessState extends SocialStates{}

// get post

class SocialGetPostLoadingState extends SocialStates{}

class SocialGetPostSuccessState extends SocialStates{}

class SocialGetPostErrorState extends SocialStates{
  final String error;

  SocialGetPostErrorState(this.error);
}

class SocialPostLikeSuccessState extends SocialStates{}

class SocialPostLikeErrorState extends SocialStates{
  final String error;

  SocialPostLikeErrorState(this.error);
}

class SocialPostCommentSuccessState extends SocialStates{}

class SocialPostCommentErrorState extends SocialStates{
  final String error;

  SocialPostCommentErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{
  final String error;

  SocialSendMessageErrorState(this.error);
}

class SocialGetMessageSuccessState extends SocialStates{}

class SocialGetMessageErrorState extends SocialStates{
  final String error;

  SocialGetMessageErrorState(this.error);
}

