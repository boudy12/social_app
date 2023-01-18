import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_app/login/cubit/cubit.dart';
import 'package:social_app/modules/social_app/login/cubit/states.dart';
import 'package:social_app/modules/social_app/register/rigester_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/styles/colors.dart';

class SocialAppLoginScreen extends StatelessWidget  {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAppLoginCubit(),
      
      child: BlocConsumer<SocialAppLoginCubit, SocialAppLoginStates>(
        listener: (context, state) {
          if(state is SocialAppLoginErrorState)
            {
              showToast(msg: state.error, state: ToastStates.ERROR);
            }
          if(state is SocialAppLoginSuccessState)
            {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                navigateAndFinishSS(context, SocialAppLayoutScreen());
              });
            }
        },

        builder: (context, state) {
          var cubit = SocialAppLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText2,

                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            onTap: () {},
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'email must not be empty';
                              }
                              return null;
                            },

                            text: 'Email',
                            prefixIcon: Icons.email_outlined
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: cubit.isPassword ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                            isPasswordIcons: cubit.isPassword,
                            prefixpress: (){
                              cubit.changIconPasswordState();
                            },
                            onTap: () {},
                            onSubmit: (value){
                              if(formKey.currentState!.validate())
                              {
                                // cubit.userLogin(
                                //   email: emailController.text,
                                //   password: passwordController.text,
                                // );
                              }
                            },
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'password must not be empty';
                              }
                              return null;
                            },

                            text: 'Password',
                            prefixIcon: Icons.lock_outline
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialAppLoginLoadingState,
                          builder: (context) => Center(
                            child: defaultButton(
                                function:(){
                                  if(formKey.currentState!.validate())
                                    {
                                      cubit.userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                      );
                                    }

                                },
                                text: 'Login',
                                radius: 10,
                                background: defaultColor,
                                isUpperCase: true,
                                width: 200
                            ),
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'don\'t hane an account ?',
                            ),
                            TextButton(
                              onPressed: (){
                                navigateTo(context, SocialAppRegisterScreen());
                              },
                              child: const Text(
                                'Register now',
                              ),
                            ),
                          ],
                        ),
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
