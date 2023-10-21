import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constant/images.dart';
import '../../../core/error/failures.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/usecases/user/sign_up_usecase.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/input_form_button.dart';
import '../../widgets/input_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is UserLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is UserLogged) {
          context.read<CartBloc>().add(const GetCart());
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.home,
            ModalRoute.withName(''),
          );
        } else if (state is UserLoggedFail) {
          if (state.failure is CredentialFailure) {
            EasyLoading.showError("Username/Password Wrong!");
          } else {
            EasyLoading.showError("Error");
          }
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                      height: 80,
                      child: Image.asset(
                        kAppLogo,
                        color: Colors.black,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Please use your e-mail address to crate a new account",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InputTextFormField(
                    controller: firstNameController,
                    hint: 'First Name',
                    textInputAction: TextInputAction.next,
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This field can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InputTextFormField(
                    controller: lastNameController,
                    hint: 'Last Name',
                    textInputAction: TextInputAction.next,
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This field can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InputTextFormField(
                    controller: emailController,
                    hint: 'Email',
                    textInputAction: TextInputAction.next,
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This field can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InputTextFormField(
                    controller: passwordController,
                    hint: 'Password',
                    textInputAction: TextInputAction.next,
                    isSecureField: true,
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This field can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InputTextFormField(
                    controller: confirmPasswordController,
                    hint: 'Confirm Password',
                    isSecureField: true,
                    textInputAction: TextInputAction.go,
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'This field can\'t be empty';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      if (_formKey.currentState!.validate()) {
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                        } else {
                          context.read<UserBloc>().add(SignUpUser(SignUpParams(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          )));
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InputFormButton(
                    color: Colors.black87,
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                        } else {
                          context.read<UserBloc>().add(SignUpUser(SignUpParams(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              )));
                        }
                      }
                    },
                    titleText: 'Sign Up',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputFormButton(
                    color: Colors.black87,
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    titleText: 'Back',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
