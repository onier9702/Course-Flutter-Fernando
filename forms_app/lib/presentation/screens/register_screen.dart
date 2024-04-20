import 'package:flutter/material.dart';

import 'package:forms_app/presentation/widgets/widgets.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register here'),
      ),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {

  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            FlutterLogo(size: 100),

            _RegisterForm(),

            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {

  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

  // Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey, // assign the _formKey to the form
      child: Column(
        children: [

          CustomTextFormField(
            label: 'Username',
            onChanged: (value) => username = value,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Username is required';
              if (value.length < 6) return 'Username should have 6 letters or more';

              return null;
            },
          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'Email',
            onChanged: (value) => email = value,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Username is required';
              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );

              if (!emailRegExp.hasMatch(value)) return 'Email has an invalid format';

              return null;
            },
          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'Password',
            obscurePassword: true,
            onChanged: (value) => password = value,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Username is required';
              if (value.length < 6) return 'Password should have 6 characters or more';

              return null;
            },
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: () {
              // print('$username, $email, $password');
              final isValid = _formKey.currentState!.validate();
              if (!isValid) return;

            },
            icon: const Icon(Icons.save),
            label: const Text('Submit', style: TextStyle(fontSize: 25)),
          ),

        ],
      ),
    );
  }
}
