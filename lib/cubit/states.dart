abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialAppChangeBottomNavState extends SocialStates {}

class SocialAddNewPostState extends SocialStates {}

// update profile
class ProfileImagePickedSuccessState extends SocialStates {}

class ProfileImagePickedErrorState extends SocialStates {}

class CoverImagePickedSuccessState extends SocialStates {}

class CoverImagePickedErrorState extends SocialStates {}

class UploadProfileImageLoadingState extends SocialStates {}

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

class UploadCoverImageLoadingState extends SocialStates {}

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

class UpdateUserDataErrorState extends SocialStates {}

class UpdateUserDataSuccessState extends SocialStates {}

class UpdateUserDataLoadingState extends SocialStates {}

// Create post
class CreatePostLoadingState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}

class PostImagePickedSuccessState extends SocialStates {}

class PostImagePickedErrorState extends SocialStates {}

class UploadPostImageSuccessState extends SocialStates {}

class UploadPostImageErrorState extends SocialStates {}
class RemovePostImageState extends SocialStates {}


 // Get Posts
class GetPostLoadingState extends SocialStates {}

class GetPostSuccessState extends SocialStates {}

class GetPostErrorState extends SocialStates {}

// Like Post
class LikePostLoadingState extends SocialStates {}

class LikePostSuccessState extends SocialStates {}

class LikePostErrorState extends SocialStates {}

