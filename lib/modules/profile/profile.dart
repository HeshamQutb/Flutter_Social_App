import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';



class ProfileScreen extends StatefulWidget {


  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoaded = false;
  @override
  void initState() {
    SocialCubit.get(context).getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialGetUserLoadingState) {
          isLoaded = false;
        } else {
          isLoaded = true;
        }
      },
      builder: (context, state) {

        var model = SocialCubit.get(context).userModel;
        return isLoaded
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      model?.cover ??
                                          'https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg',
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            radius: 62,
                            child: CachedNetworkImage(
                              imageUrl: model?.image ??
                                  'https://img.freepik.com/free-icon/man_318-677829.jpg',
                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                radius: 60,
                                backgroundImage: imageProvider,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      model?.name ?? 'h',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model?.bio ?? 'add bio here ... ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Posts',
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '10k',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Followers',
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '21',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Following',
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {},
                              child: Text('Add Post',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              navigateTo(context, const EditProfileScreen());
                            },
                            child: Icon(
                              IconBroken.Edit,
                              color: Theme.of(context).iconTheme.color,
                            )),
                      ],
                    )
                  ],
                ),
              )
            : getShimmerLoading(context);
      },
    );
  }
}

Shimmer getShimmerLoading(context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                          color: Colors
                              .grey[300], // Shimmer color for the cover image
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors
                          .white, // Shimmer color for the avatar background
                      radius: 64,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[
                            300], // Shimmer color for the avatar image background
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 100,
                height: 20,
                color: Colors.grey[300], // Shimmer color for the name
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 15,
                color: Colors.grey[300], // Shimmer color for the bio
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 30,
                          height: 20,
                          color: Colors
                              .grey[300], // Shimmer color for the post count
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 40,
                          height: 10,
                          color: Colors
                              .grey[300], // Shimmer color for the "Posts" text
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 30,
                          height: 20,
                          color: Colors.grey[
                              300], // Shimmer color for the follower count
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 60,
                          height: 10,
                          color: Colors.grey[
                              300], // Shimmer color for the "Followers" text
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.grey[
                              300], // Shimmer color for the following count
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 70,
                          height: 10,
                          color: Colors.grey[
                              300], // Shimmer color for the "Following" text
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Add Post',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  OutlinedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.edit,
                      color:
                          Colors.grey[300], // Shimmer color for the edit icon
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
