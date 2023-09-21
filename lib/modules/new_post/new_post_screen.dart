import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../layout/cubit/states.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialCreatePostSuccessState){
          setState(() {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        var textController = TextEditingController();
        var model = SocialCubit.get(context).userModel;
        return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: const Text(
                'Create Post',
                style: TextStyle(fontSize: 20),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2),
              ),
              actions: [
                defaultTextButton(onPressed: () {
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('dd/MM/yyyy').format(now);
                  String formattedTime = DateFormat('HH:mm a').format(now);

                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createNewPost(
                      dateTime: formattedDate,
                      clockTime: formattedTime,
                      text: textController.text,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: formattedDate,
                      clockTime: formattedTime,
                      text: textController.text,
                    );
                  }
                }, text: 'Post'),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SocialCreatePostLoadingState)
                    const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          model?.image,
                        ),
                        radius: 25,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model?.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(height: 1.4),
                          ),
                          Text(
                            'Public',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(height: 1.4),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                          hintText: 'what is your mind,?',
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if(SocialCubit.get(context).postImage != null)
                    Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: FileImage(SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CircleAvatar(
                            radius: 13,
                            child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).removePostImage();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 10,
                                )
                            )
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              SocialCubit.get(context).getPostImageGallery();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconBroken.Image),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Add Photo'),
                              ],
                            )),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.tag),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Tags'),
                              ],
                            )),
                      )
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
