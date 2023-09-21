import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatefulWidget {
  UserModel model;

  ChatDetailsScreen({super.key, required this.model});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: widget.model.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(IconBroken.Arrow___Left_2),
                ),
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(widget.model.image),
                      radius: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.model.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(height: 1.4),
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemBuilder: (context, index) {
                          var message = SocialCubit.get(context).messages[index];
                          if (message.senderId == uId) {
                            return buildMyMessage(message);
                          }
                          return buildMessage(message);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                        itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller:
                                    SocialCubit.get(context).messageController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type Your Message Here ...'),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: defaultColor,
                            child: Row(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                      dateTime: DateTime.now().toString(),
                                      senderId: SocialCubit.get(context).userModel?.uId,
                                      receiverId: widget.model.uId,
                                      text: SocialCubit.get(context).messageController.text,
                                    );
                                    SocialCubit.get(context).clearField();
                                  },
                                  minWidth: 1.0,
                                  child: const Icon(
                                    IconBroken.Send,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        },
      );
    });
  }

  Widget buildMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )),
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            messageModel.text,
          ),
        ),
      );
  Widget buildMyMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(.4),
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )),
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            messageModel.text,
          ),
        ),
      );
}

