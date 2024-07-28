import 'package:flutter/material.dart';
import 'package:pingolearn_task1/constants/text_styles.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../news_feed/presentation/news_screen.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../providers/provider_auth.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "MyNews",
                  style: boldText(primary),
                ),
                const Spacer(flex: 10),
                AppTextField(
                  controller: authProvider.nameTextController,
                  hintText: "Name",
                ),
                const SizedBox(height: 20.0),
                AppTextField(
                  controller: authProvider.emailTextController,
                  hintText: "Email",
                ),
                const SizedBox(
                  height: 20.0,
                ),
                AppTextField(
                  controller: authProvider.passwordTextController,
                  hintText: "Password",
                  isPassword: true,
                ),
                const SizedBox(height: 12.0),
                const Spacer(flex: 9),
                authProvider.loading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : AppButton(
                        text: "Signup",
                        onTap: () async {
                          final response = await authProvider.signUpUser();
                          if (response["status"] == "success") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewsScreen(),
                              ),
                            );
                          } else {
                            var snackBar = SnackBar(
                              content: Text(response["reason"].toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                      ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?", style: regularText),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Login", style: boldText(primary)),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
