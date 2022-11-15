import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/cubit/cubit.dart';
import 'package:socail_app/cubit/states.dart';
import 'package:socail_app/shared/components/components.dart';
import 'package:socail_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var bioController = TextEditingController();
        var cubit = SocialCubit.get(context);
        var profileImage = cubit.profileImage;
        var coverImage = cubit.coverImage;

        nameController.text = cubit.userModel!.name!;
        bioController.text = cubit.userModel!.bio!;
        phoneController.text = cubit.userModel!.phone!;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                function: () {
                  cubit.updateUser(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                text: 'Update',
              ),
              SizedBox(
                width: 7.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  if (state is UpdateUserDataLoadingState)
                    SizedBox(
                      height: 15.0,
                    ),
                  SizedBox(
                    height: 195.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${cubit.userModel!.cover}',
                                          )
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.getCoverImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        '${cubit.userModel!.image}',
                                      )
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getProfileImage();
                              },
                              icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  function: () {
                                    cubit.uploadProfileImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                  },
                                  text: 'upload profile'),
                              if (state is UpdateUserDataLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is UpdateUserDataLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                        SizedBox(
                          width: 7.0,
                        ),
                        if (cubit.coverImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  function: () {
                                    cubit.uploadCoverImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                  },
                                  text: 'upload cover'),
                              if (state is UpdateUserDataLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is UpdateUserDataLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                      ],
                    ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Name must not be empty";
                      }
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Bio must not be empty";
                      }
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Phone must not be empty";
                      }
                    },
                    label: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
