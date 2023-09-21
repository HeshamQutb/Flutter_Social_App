import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu_outlined)),
            title: Text(
                cubit.titles[cubit.currentIndex],
              style: const TextStyle(
                  fontSize: 20
              ),
            ),
            titleSpacing: 0.0,
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: const Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton:CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 21,
            child: FloatingActionButton(
              mini: true  ,
              onPressed: (){
                navigateTo(context, const NewPostScreen());
              },
              child: const Icon(Icons.add
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            notchMargin: 5.0,
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeNavBar(index);
              },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                          IconBroken.Home
                      ),
                      label: 'Home'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          IconBroken.Chat
                      ),
                    label: 'Chats'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          IconBroken.User
                      ),
                      label: 'Users'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          IconBroken.Profile
                      ),
                      label: 'Profile'
                  ),
                ]
            ),
          ),
        );
      },
    );
  }
}
