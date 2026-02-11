import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

import 'package:eshop/core/constant/app_sizes.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:eshop/core/constant/validators.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/router/app_router.dart';
import 'package:eshop/core/widgets/input_form_button.dart';
import 'package:eshop/core/widgets/input_text_form_field.dart';
import 'package:eshop/features/auth/domain/usecases/user/sign_up_usecase.dart';
import 'package:eshop/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:eshop/features/cart/presentation/bloc/cart/cart_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
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
            (Route<dynamic> route) => false,
          );
        } else if (state is UserLoggedFail) {
          String errorMessage = "An error occurred. Please try again.";
          if (state.failure is CredentialFailure) {
            errorMessage = "Incorrect username or password.";
          } else if (state.failure is NetworkFailure) {
            errorMessage = "Network error. Check your connection.";
          }
          EasyLoading.showError(errorMessage);
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingMedium),
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
                    height: 10,
                  ),
                  const Text(
                    "Please use your e-mail address to crate a new account",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  InputTextFormField(
                    controller: _firstNameController,
                    hint: 'First Name',
                    textInputAction: TextInputAction.next,
                    validation: (String? val) =>
                        Validators.validateField(val, "First name"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InputTextFormField(
                    controller: _lastNameController,
                    hint: 'Last Name',
                    textInputAction: TextInputAction.next,
                    validation: (String? val) =>
                        Validators.validateField(val, "Last name"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InputTextFormField(
                    controller: _emailController,
                    hint: 'Email',
                    textInputAction: TextInputAction.next,
                    validation: (String? val) => Validators.validateEmail(val),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InputTextFormField(
                    controller: _passwordController,
                    hint: 'Password',
                    textInputAction: TextInputAction.next,
                    isSecureField: true,
                    validation: (String? val) =>
                        Validators.validateField(val, "Password"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InputTextFormField(
                    controller: _confirmPasswordController,
                    hint: 'Confirm Password',
                    isSecureField: true,
                    textInputAction: TextInputAction.go,
                    validation: (String? val) =>
                        Validators.validatePasswordMatch(
                      val,
                      _passwordController.text,
                    ),
                    onFieldSubmitted: (_) => _onSignUp(context),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  InputFormButton(
                    color: Colors.black87,
                    onClick: () => _onSignUp(context),
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

  void _onSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        EasyLoading.showError("Passwords do not match!");
        return;
      }
      context.read<UserBloc>().add(SignUpUser(SignUpParams(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          )));
    }
  }
}
