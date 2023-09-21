// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var model = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = model?.name;
        phoneController.text = model?.phone;
        bioController.text = model!.bio!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                setState(() {
                  SocialCubit.get(context).getUserData();
                  Navigator.pop(context);
                });
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
            actions: [
              defaultTextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUserInfo(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                    Navigator.pop(context);
                    }, text: 'update'),
              const SizedBox(
                width: 5,
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? CachedNetworkImageProvider(
                                        model.cover ??
                                            'https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg',
                                      )
                                          : FileImage(coverImage) as ImageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: CircleAvatar(
                                    radius: 18,
                                    child: IconButton(
                                        onPressed: () {
                                          print('Change cover');
                                          showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                height: 138,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
                                                      leading: const Icon(IconBroken.Camera),
                                                      title: const Text('Take a photo'),
                                                      onTap: () {
                                                        SocialCubit.get(context).getCoverImageCamera();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 0.5,
                                                      color: Colors.grey,
                                                    ),
                                                    ListTile(
                                                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                      leading: const Icon(IconBroken.Image),
                                                      title: const Text('Choose from gallery'),
                                                      onTap: () {
                                                        SocialCubit.get(context).getCoverImageGallery();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 0.5,
                                                      color: Colors.grey,
                                                    ),
                                                    defaultTextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        text: 'Cancel',
                                                        size: 15
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          IconBroken.Camera,
                                          size: 18,
                                        )
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              radius: 62,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? CachedNetworkImageProvider(model.image)
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: CircleAvatar(
                                  radius: 18,
                                  child: IconButton(
                                      onPressed: () {
                                        print('Change image');
                                        showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 138,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListTile(
                                                    visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
                                                    leading: const Icon(IconBroken.Camera),
                                                    title: const Text('Take a photo'),
                                                    onTap: () {
                                                      SocialCubit.get(context).getProfileImageCamera();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 0.5,
                                                    color: Colors.grey,
                                                  ),
                                                  ListTile(
                                                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                    leading: const Icon(IconBroken.Image),
                                                    title: const Text('Choose from gallery'),
                                                    onTap: () {
                                                      SocialCubit.get(context).getProfileImageGallery();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 0.5,
                                                    color: Colors.grey,
                                                  ),
                                                  defaultTextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    text: 'Cancel',
                                                    size: 15
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        IconBroken.Camera,
                                        size: 18,
                                      )
                                  )
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Name Must\'t be Empty';
                        } else {
                          return null;
                        }
                      },
                      label: 'Name',
                      prefixIcon: IconBroken.Profile),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Bio Must\'t be Empty';
                        } else {
                          return null;
                        }
                      },
                      label: 'Bio',
                      prefixIcon: IconBroken.Info_Circle),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Phone Number Must\'t be Empty';
                        } else {
                          return null;
                        }
                      },
                      label: 'Phone Number',
                      prefixIcon: IconBroken.Call)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
