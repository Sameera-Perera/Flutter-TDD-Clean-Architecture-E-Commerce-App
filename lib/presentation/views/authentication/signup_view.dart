import 'package:eshop/presentation/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/images.dart';
import '../../widgets/input_form_button.dart';
import '../../widgets/input_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
          body: SingleChildScrollView(
        child: SafeArea(
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
                  "Please use your e-mail address to crate a new account",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                InputTextFormField(
                  controller: emailController,
                  hint: 'Full Name',
                ),
                const SizedBox(
                  height: 12,
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
                  height: 12,
                ),
                InputTextFormField(
                  controller: passwordController,
                  hint: 'Confirm Password',
                  isSecureField: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                InputFormButton(
                  color: Colors.black87,
                  onClick: () {
                    // context.read<AuthBloc>().add(SignInAuth());
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
                // const SizedBox(
                //   height: 12,
                // ),
                // InputTextButton(
                //   onClick: () {
                //     Navigator.of(context).pop();
                //   },
                //   titleText: 'Back',
                // ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
