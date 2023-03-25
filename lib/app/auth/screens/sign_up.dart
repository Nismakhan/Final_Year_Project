import 'package:final_year_project/app/auth/controller/auth_controller.dart';
import 'package:final_year_project/app/auth/models/user_model.dart';
import 'package:final_year_project/app/auth/widgets/my_buttions.dart';
import 'package:final_year_project/app/auth/widgets/my_radio_buttons.dart';
import 'package:final_year_project/app/auth/widgets/decoration_for_textfields.dart';
import 'package:final_year_project/app/auth/widgets/third_party_icons.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const MyRadioButtons(),
                        Container(
                          decoration: decorationForTextFieldsContainers(),
                          width: 300,
                          child: TextFormField(
                            controller: _nameController,
                            validator: ((value) {
                              if (value != null) {
                                return null;
                              } else {
                                return "Name is required";
                              }
                            }),
                            decoration: decorationForTextfields(
                                text: "Enter Name", icon: Icons.person),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: decorationForTextFieldsContainers(),
                          width: 300,
                          child: TextFormField(
                              controller: _emailController,
                              validator: ((value) {
                                final expression = RegExp("");
                                if (!expression.hasMatch(value!)) {
                                  return "";
                                }
                                return null;
                              }),
                              decoration: decorationForTextfields(
                                  text: "Enter Email", icon: Icons.email)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: decorationForTextFieldsContainers(),
                          width: 300,
                          child: TextFormField(
                              controller: _contactController,
                              validator: ((value) {
                                final expression = RegExp(
                                    r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$");
                                if (!expression.hasMatch(value!)) {
                                  return "The number should be 11 digits";
                                }
                                return null;
                              }),
                              decoration: decorationForTextfields(
                                  text: "Enter Your Contact",
                                  icon: Icons.call)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: decorationForTextFieldsContainers(),
                          width: 300,
                          child: TextFormField(
                            controller: _passwordController,
                            obscuringCharacter: "*",
                            obscureText: true,
                            validator: ((value) {
                              if (value!.length < 8) {
                                return "password shold be atleast 8 characters";
                              }
                              return null;
                            }),
                            decoration: InputDecoration(
                              label: const Text('Enter Password'),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 3)),
                              suffixIcon: const Icon(
                                Icons.lock,
                                size: 25,
                                color: Colors.blue,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyButtions(
                          text: "Sign Up",
                          onSelect: () async {
                            if (_formKey.currentState!.validate()) {
                              final user = UserModel(
                                uid: "",
                                name: _nameController.text,
                                email: _emailController.text,
                                contactNumber: _contactController.text,
                              );
                              await context
                                  .read<AuthController>()
                                  .signUpWithEmailAndPassword(context,
                                      name: user,
                                      email: user,
                                      contact: user,
                                      password: _passwordController.text);
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRouter.dashboard);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "forgot passward ? ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Click here",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C63FF),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text("Or"),
                        const SizedBox(
                          height: 10,
                        ),
                        const ThirdPartyIcons()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
