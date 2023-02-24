import 'package:final_year_project/app/auth/widgets/my_buttions.dart';
import 'package:final_year_project/app/auth/widgets/my_radio_buttons.dart';

import 'package:final_year_project/app/auth/widgets/third_party_icons.dart';
import 'package:final_year_project/app/router/router.dart';
import 'package:flutter/material.dart';

class TextFieldsAndButtonsColumn extends StatelessWidget {
  TextFieldsAndButtonsColumn({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const MyRadioButtons(),
          //  MyTextFields(
          //   text: "Example@gmail.com",
          //   icons: Icons.person,
          //   regExp:
          //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
          //   errorText: "email is invalid",
          // ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 226, 226),
              borderRadius: BorderRadius.circular(20),
            ),
            width: 300,
            child: TextFormField(
              validator: ((value) {
                final expression = RegExp("");
                if (!expression.hasMatch(value!)) {
                  return "";
                }
                return null;
              }),
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.abc,
                ),
                labelText: "text",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border:  OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 226, 226),
              borderRadius: BorderRadius.circular(20),
            ),
            width: 300,
            child: TextFormField(
              validator: ((value) {
                final expression = RegExp("");
                if (!expression.hasMatch(value!)) {
                  return "";
                }
                return null;
              }),
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.abc,
                ),
                labelText: "**********",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MyButtions(
            text: "Login",
            onSelect: () async {
              if (_formKey.currentState!.validate()) {}
            },
          ),
          const SizedBox(
            height: 20,
          ),
          MyButtions(
            text: "SignUp",
            onSelect: () {
              Navigator.of(context).pushReplacementNamed(AppRouter.signUp);
            },
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
    );
  }
}

class TextfieldsAndButtonsForSignUp extends StatelessWidget {
  const TextfieldsAndButtonsForSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyRadioButtons(),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 226, 226, 226),
            borderRadius: BorderRadius.circular(20),
          ),
          width: 300,
          child: TextFormField(
            validator: ((value) {
              final expression = RegExp("");
              if (!expression.hasMatch(value!)) {
                return "";
              }
              return null;
            }),
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.abc,
              ),
              labelText: "text",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border:  OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 226, 226, 226),
            borderRadius: BorderRadius.circular(20),
          ),
          width: 300,
          child: TextFormField(
            validator: ((value) {
              final expression = RegExp("");
              if (!expression.hasMatch(value!)) {
                return "";
              }
              return null;
            }),
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.abc,
              ),
              labelText: "text",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border:  OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 226, 226, 226),
            borderRadius: BorderRadius.circular(20),
          ),
          width: 300,
          child: TextFormField(
            validator: ((value) {
              final expression = RegExp("");
              if (!expression.hasMatch(value!)) {
                return "";
              }
              return null;
            }),
            decoration:const InputDecoration(
              suffixIcon: Icon(
                Icons.abc,
              ),
              labelText: "text",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 226, 226, 226),
            borderRadius: BorderRadius.circular(20),
          ),
          width: 300,
          child: TextFormField(
            validator: ((value) {
              final expression = RegExp("");
              if (!expression.hasMatch(value!)) {
                return "";
              }
              return null;
            }),
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.abc,
              ),
              labelText: "text",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
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
          onSelect: () {},
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
    );
  }
}
