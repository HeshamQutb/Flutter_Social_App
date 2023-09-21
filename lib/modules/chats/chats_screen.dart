import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    SocialCubit.get(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 1.0,
                ),
              ),
              itemCount: SocialCubit.get(context).users.length
          ),
          fallback: (context) => getShimmerLoading(),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model,context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(model: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                model.image
            ),
            radius: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${model.name}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(height: 1.4),
          )
        ],
      ),
    ),
  );

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                ),
                const SizedBox(width: 10),
                Container(
                  width: 250,
                  height: 20,
                  color: Colors.white,
                ),

              ],
            ),
          ),
          itemCount: 15,
        ),
      ),
    );
  }
}

