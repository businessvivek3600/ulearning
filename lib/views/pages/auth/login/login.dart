import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/blocs/index.dart';
import 'package:ulearning_app/constants/img_const.dart';
import 'package:ulearning_app/utils/extentions/index.dart';
import 'package:ulearning_app/utils/index.dart';
import 'package:ulearning_app/views/pages/index.dart';

import '../../../widgets/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier<bool> rememberMe = ValueNotifier(false);
  ValueNotifier<bool> termsCondition = ValueNotifier(false);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showLoading();
        } else {
          hideLoading();
          if (state is LoginSuccess) {
            successToast(state.message ?? 'Login success');
          } else if (state is LoginFailure) {
            errorToast(state.message ?? 'Login failed');
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: transparentAppBar(
            context,
            title: 'Log In',
            theme: true,
            height: 0,
            centerTile: true,
          ),
          body: Column(
            children: [
              10.height,
              const Text('Log In'),
              Divider(color: Colors.grey[200], thickness: 1),
              Column(
                children: [
                  _socialLogin(),
                  const SizedBox(height: 20),
                  Text('Or user your email account to log in',
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey)),
                  50.height,
                  _form(state).expand(),
                  ElevatedButton(
                          onPressed: () => _login(EmailAuth(
                              email: state.email, password: state.password)),
                          child: const Text('Log In'))
                      .expand()
                      .row(),
                  OutlinedButton(onPressed: () {}, child: const Text('Sign Up'))
                      .expand()
                      .row(),
                ],
              ).paddingSymmetric(vertical: 20.h, horizontal: 20.w).expand(),
            ],
          ),
        );
      },
    );
  }

  void _login(LoginMethod method) async {
    if (!termsCondition.value) {
      infoToast('Please agree to the terms and conditions');
      return;
    }
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    TextInput.finishAutofillContext();

    context.read<LoginBloc>().add(LoginAttemptEvent(method));
  }

  Widget _form(LoginState state) {
    return SingleChildScrollView(
      child: AutofillGroup(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              MyTextTheme(
                controller: TextEditingController(),
                onChanged: (value) =>
                    context.read<LoginBloc>().add(LoginEmailChanged(value)),
                label: 'Email',
                prefix: const Icon(Icons.email),
                isPassword: false,
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                hint: 'Enter your email',
                autofillHints: const [
                  AutofillHints.email,
                  AutofillHints.username,
                  AutofillHints.newUsername,
                ],
              ),
              const SizedBox(height: 20),
              MyTextTheme(
                controller: TextEditingController(),
                onChanged: (value) =>
                    context.read<LoginBloc>().add(LoginPasswordChanged(value)),
                onSubmit: (p0) => _login(
                    EmailAuth(email: state.email, password: state.password)),
                label: 'Password',
                prefix: const Icon(Icons.lock),
                isPassword: true,
                inputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                hint: 'Enter your password',
                autofillHints: const [
                  AutofillHints.newPassword,
                  AutofillHints.password,
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ValueListenableBuilder<bool>(
                          valueListenable: rememberMe,
                          builder: (context, value, child) {
                            return Checkbox(
                                value: value,
                                onChanged: (value) {
                                  rememberMe.value = value!;
                                });
                          }),
                      const Text('Remember me'),
                    ],
                  ),
                  const Text('Forgot password?').onTap(() {}, radius: 3),
                ],
              ),
              Row(
                children: [
                  ValueListenableBuilder<bool>(
                      valueListenable: termsCondition,
                      builder: (context, value, child) {
                        return Checkbox(
                            value: value,
                            onChanged: (value) {
                              termsCondition.value = value!;
                            });
                      }),
                  RichText(
                    text: TextSpan(
                      text: 'I agree to the ',
                      style: context.textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ).expand(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _socialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(MyPng.googleLogo, width: 30.w)
            .onTap(() => _login(GoogleAuth())),
        Image.asset(MyPng.appleLogo, width: 30.w).onTap(() {}),
        Image.asset(MyPng.facebookLogo, width: 30.w).onTap(() {}),
      ],
    );
  }
}