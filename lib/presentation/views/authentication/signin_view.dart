import 'package:eshop/presentation/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        // EasyLoading.dismiss();
        // if (state is AuthLoading) {
        //   EasyLoading.show(status: 'Loading...');
        // } else if (state is AuthSuccess) {
        //   Navigator.of(context).pushNamedAndRemoveUntil(
        //     AppRouter.home,
        //     ModalRoute.withName(''),
        //   );
        // }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                    height: 180,
                    child: Image.asset("assets/images/app_logo.png")),
                const Text(
                  "Please enter your e-mail address and password to sign-in",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
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
                  onClick: () {
                    // context.read<AuthBloc>().add(SignInAuth());
                  },
                  titleText: 'Sign In',
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
                          // Navigator.pushNamed(context, AppRouter.signUp);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
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
