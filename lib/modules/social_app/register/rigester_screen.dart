import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_app/register/cubit/cubit.dart';
import 'package:social_app/modules/social_app/register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/styles/colors.dart';

class SocialAppRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAppRegisterCubit(),

      child: BlocConsumer<SocialAppRegisterCubit, SocialAppRegisterStates>(
        listener: (context, state) {
          if(state is SocialAppCreateUserSuccessState)
            {
              navigateAndFinishSS(context, SocialAppLayoutScreen());
            }
        },
        builder: (context, state) {
          var cubit = SocialAppRegisterCubit.get(context);
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
                          'Register',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText2,

                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Name Must Not Be Empty';
                              }
                              return null;
                            },
                            onTap: () {},
                            text:  'Name',
                            prefixIcon: Icons.person_outline
                        ),
                        const SizedBox(height: 15,),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Email Must Not Be Empty';
                              }
                              return null;
                            },
                            onTap: () {},
                            text: 'Email',
                            prefixIcon:  Icons.email_outlined
                        ),
                        const SizedBox(height: 15,),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Phone Must Not Be Empty';
                              }
                              return null;
                            },
                            onTap: () {},
                            text:  'Phone',
                            prefixIcon:  Icons.phone
                        ),
                        const SizedBox(height: 15,),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            isPasswordIcons: cubit.isPassword,
                            suffix: cubit.suffix,
                            prefixpress: (){
                              cubit.changIconRegisterPasswordState();
                            },
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'Password Must Not Be Empty';
                              }
                              return null;
                            },
                            onTap: () {},
                            text: 'Password',
                            prefixIcon: Icons.lock_outlined
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialAppRegisterLoadingState,
                          builder: (context) => Center(
                            child: defaultButton(
                                function:(){
                                  if(formKey.currentState!.validate())
                                  {
                                    cubit.userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      name: nameController.text,
                                    );
                                  }

                                },
                                text: 'Register',
                                radius: 10,
                                background: defaultColor,
                                isUpperCase: true,
                                width: 200
                            ),
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
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
