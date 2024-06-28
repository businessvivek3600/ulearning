import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/blocs/index.dart';
import 'package:ulearning_app/utils/extentions/index.dart';
import 'package:ulearning_app/utils/index.dart';
import 'package:ulearning_app/views/pages/index.dart';

import '../../../widgets/index.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String routeName = '/sign-up';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ValueNotifier<bool> rememberMe = ValueNotifier(false);
  ValueNotifier<bool> termsCondition = ValueNotifier(false);
  final formKey = GlobalKey<FormState>();
  late LoginBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<LoginBloc>();
    bloc.add(LoginInitialEvent());
  }

  @override
  void dispose() {
    super.dispose();
    rememberMe.dispose();
    termsCondition.dispose();
    bloc.add(LoginInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showLoading();
        } else {
          hideLoading();
          if (state is LoginSuccess) {
            successToast(state.message ?? 'Sign up success');
          } else if (state is LoginFailure) {
            errorToast(state.message ?? 'Sign up failed');
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: transparentAppBar(
            context,
            title: 'Sign Up',
            theme: true,
            height: 0,
            centerTile: true,
          ),
          body: Column(
            children: [
              20.height,
              RichText(
                text: TextSpan(
                  text: 'Sign up to get started',
                  style: context.textTheme.titleLarge?.copyWith(),
                  children: [
                    TextSpan(
                      text: ' with uLearning',
                      style: context.textTheme.titleLarge?.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: 20.w),
              10.height,
              Divider(color: Colors.grey[200], thickness: 1),
              Column(
                children: [
                  _form(state).expand(),
                  ElevatedButton(
                          onPressed: () => _signUp(EmailAuth(
                              email: state.email, password: state.password)),
                          child: const Text('Sign Up'))
                      .expand()
                      .row(),
                  OutlinedButton(
                          onPressed: () => goTo(context, LoginPage.routeName),
                          child: const Text('Log In'))
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

  void _signUp(LoginMethod method) async {
    if (!termsCondition.value) {
      infoToast('Please agree to the terms and conditions');
      return;
    }
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (method is EmailAuth) {
      if (rememberMe.value) TextInput.finishAutofillContext();
      formKey.currentState!.save();
    }
    context.read<LoginBloc>().add(RegisterAttemptEvent(method));
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
                onSubmit: (p0) => _signUp(
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchTermsAndConditions(context),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchPrivacyPolicy(context),
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
}
