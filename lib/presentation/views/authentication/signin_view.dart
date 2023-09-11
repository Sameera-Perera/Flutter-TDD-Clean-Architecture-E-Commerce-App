import 'package:eshop/core/error/failures.dart';
import 'package:eshop/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constant/images.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/usecases/user/sign_in_usecase.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/input_form_button.dart';
import '../../widgets/input_text_form_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
        } else if(state is UserLoggedFail){
          // print(state.failure);
          if(state.failure is CredentialFailure){
            EasyLoading.showError("Username/Password Wrong!");
          } else {
            EasyLoading.showError("Error");
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 75,
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
                  "Please enter your e-mail address and password to sign-in",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const Spacer(
                  flex: 2,
                ),
                const SizedBox(
                  height: 24,
                ),
                InputTextFormField(
                  controller: emailController,
                  hint: 'Email',
                ),
                const SizedBox(
                  height: 12,
                ),
                InputTextFormField(
                  controller: passwordController,
                  hint: 'Password',
                  isSecureField: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, AppRouter.forgotPassword);
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                InputFormButton(
                  color: Colors.black87,
                  onClick: () {
                    context.read<UserBloc>().add(SignInUser(SignInParams(
                          username: emailController.text,
                          password: passwordController.text,
                        )));
                  },
                  titleText: 'Sign In',
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account! ',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRouter.signUp);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
