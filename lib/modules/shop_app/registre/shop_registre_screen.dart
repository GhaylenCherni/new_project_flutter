import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/shop_layout.dart';
import 'package:udemy_flutter/modules/shop_app/Registre/cubit/states.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/cubit.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutter/modules/shop_app/registre/cubit/cubit.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class ShopRegistreScreen extends StatelessWidget
{

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopRegistreCubit(),
      child: BlocConsumer<ShopRegistreCubit,ShopRegistreStates>(
        listener:(context,state)
        {
          if (state is ShopRegistreSuccessState) {
            String message = state.loginModel?.message ?? "An error occurred";

            if (state.loginModel?.status == true) {
              print(state.loginModel?.data?.token);
              print(message);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel?.data?.token,
              ).then((value) {
                token = state!.loginModel!.data!.token!;
                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
              // Fluttertoast.showToast(
              //   msg: message,
              //   toastLength: Toast.LENGTH_LONG,
              //   gravity: ToastGravity.BOTTOM,
              //   timeInSecForIosWeb: 5,
              //   backgroundColor: Colors.green, // You might want to change the background color for success
              //   textColor: Colors.white,
              //   fontSize: 16.0,
              // );
            } else {
              print(message);
              showToast(
                text: message,
                state: ToastStates.ERROR,
              );
              // Fluttertoast.showToast(
              //   msg: state.loginModel?.message ?? "An error occurred",
              //   toastLength: Toast.LENGTH_LONG,
              //   gravity: ToastGravity.BOTTOM,
              //   timeInSecForIosWeb: 5,
              //   backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //   fontSize: 16.0,
              // );
            }
          }
        } ,
        builder:(context,state){
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTRE',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Registre now to browse our hot offers',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          label: 'User name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                           
                          },
                          isPassword: ShopRegistreCubit.get(context).isPassword,
                          suffix: ShopRegistreCubit.get(context).suffix,
                          suffixpressed: () {
                            ShopRegistreCubit.get(context)
                                .changePassworVisiblity();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegistreLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegistreCubit.get(context).userRegistre(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'registre',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
