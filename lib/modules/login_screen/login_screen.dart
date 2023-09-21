// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../register/register_screen.dart';
import 'login_cubit/cubit.dart';
import 'login_cubit/states.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginErrorState){
            showToast(message: state.error, state: ToastState.error);
          }
          if(state is LoginSuccessState){
            CacheHelper.setData(
                key: 'uId',
                value:state.uId
            ).then((value) {
              navigateAndFinish(context, const HomeScreen());
            });
            showToast(message: 'Successfully Login', state: ToastState.success);
            setState(() {
              uId = CacheHelper.getData(key: 'uId');
            });
          }

        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Welcome Back',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Login to access your account',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultTextField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Email Address!';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultTextField(
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          controller: passwordController,
                          isPassword: cubit.isPassword,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short!';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefixIcon: Icons.lock,
                          onPressedSuffix: () {
                            cubit.changePasswordVisibility();
                          },
                          suffix: cubit.suffix,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            defaultTextButton(
                                onPressed: (){},
                                text: 'Forgot Password?',
                                isUpperCase: false
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login',
                              radius: 10.0),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Or',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            width: double.infinity, // Set the width to double.infinity
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30), // Set a circular border radius
                            ),
                            child: SignInButton(
                              Buttons.Google,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity, // Set the width to double.infinity
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30), // Set a circular border radius
                          ),
                          child: SignInButton(
                            Buttons.FacebookNew,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ! ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            defaultTextButton(
                              onPressed: () {
                                navigateTo(context, const RegisterScreen());
                              },
                              text: 'Sign up',
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
