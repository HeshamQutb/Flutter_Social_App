import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';


class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {

  bool isLoaded = false;
  @override
  void initState() {
    SocialCubit.get(context).posts = [];
    SocialCubit.get(context).getPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialGetPostLoadingState) {
          isLoaded = false;
        }
        else {
          isLoaded = true;
        }
      },
      builder: (context, state) {
        return isLoaded
            ? ConditionalBuilder(
            condition: SocialCubit.get(context).posts.isNotEmpty ,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CachedNetworkImage(
                          imageUrl: 'https://as1.ftcdn.net/v2/jpg/02/99/97/34/1000_F_299973420_Sul5SWPieQyxds20PoMDfwJOS5pQ7FvP.jpg',
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index], context, index),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 2,
                      ),
                      itemCount: SocialCubit.get(context).posts.length
                  ),
                ],
              ),
            ),
            fallback: (context) => const Center(child: Text('There is no posts'),)
        )
            : getShimmerLoading();
      },
    );
  }

  Widget buildPostItem(PostModel postModel, context, index) => Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      postModel.image,
                    ),
                    radius: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              postModel.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(height: 1.4),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.check_circle_sharp,
                              color: Colors.blueAccent,
                              size: 13,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              postModel.dateTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(height: 1.4),
                            ),
                            Text(
                              ' at ${postModel.clockTime}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                    color: Theme.of(context).iconTheme.color,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[350],
                  height: 1.0,
                ),
              ),
              Text(
                postModel.text,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10, top: 5),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 3),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(
              //                       color: Colors.blueAccent,
              //                     ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 3),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(color: Colors.blueAccent),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 3),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(color: Colors.blueAccent),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 3),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(color: Colors.blueAccent),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 3),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(color: Colors.blueAccent),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 3),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(color: Colors.blueAccent),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 3),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(color: Colors.blueAccent),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 3),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(color: Colors.blueAccent),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(postModel.postImage != '')
                Padding(
                padding: const EdgeInsets.only(
                  top: 10
                ),
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(4),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        postModel.postImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                size: 15,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes.length > index ? SocialCubit.get(context).likes[index] : 0}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                size: 15,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).comments.length > index ? SocialCubit.get(context).comments[index] : 0} Comment',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[350],
                  height: 1.0,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                           CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              SocialCubit.get(context).userModel?.image,
                            ),
                            radius: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: (){
                              SocialCubit.get(context).postComment(SocialCubit.get(context).postsId[index]);
                            },
                            child: Text(
                              'write a comment ... ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).postLike(SocialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 15,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Upload,
                          size: 15,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Share',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 80,
                              height: 10,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz),
                        color: Colors.white,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey[350],
                      height: 1.0,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 5),
                    child: Wrap(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsetsDirectional.only(end: 3),
                          child: SizedBox(
                            height: 25.0,
                            child: MaterialButton(
                              onPressed: () {},
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              child: Container(
                                width: 50,
                                height: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 15,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    width: 30,
                                    height: 15,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 25,
                                    height: 15,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    width: 30,
                                    height: 15,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey[350],
                      height: 1.0,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 18,
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 120,
                                height: 15,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Container(
                              width: 40,
                              height: 15,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Container(
                              width: 40,
                              height: 15,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
