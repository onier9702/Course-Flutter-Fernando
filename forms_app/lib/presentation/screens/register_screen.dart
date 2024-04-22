import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';

import 'package:forms_app/presentation/widgets/widgets.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register here'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
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

// Before use register cubit state, this class was an stateFullWidget and then we come back to a statelessWidget
class _RegisterForm extends StatelessWidget {

  const _RegisterForm();

  // Form
  @override
  Widget build(BuildContext context) {

    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
    final email = registerCubit.state.email;

    return Form(
      // not more necessary after use register cubit state
      // key: _formKey, // assign the _formKey to the form
      child: Column(
        children: [

          CustomTextFormField(
            label: 'Username',
            // OLD Solution without Cubit
            // onChanged: (value) => username = value,

            // Solution using Cubit
            // onChanged: (value) {
            //   registerCubit.usernameChanged(value);
            //   // _formKey.currentState?.validate();
            // },

            onChanged: registerCubit.usernameChanged,
            // not more necessary after use register cubit state
            // validator: (value) {
            //   if (value == null || value.trim().isEmpty) return 'Username is required';
            //   if (value.length < 6) return 'Username should have 6 letters or more';

            //   return null;
            // },
            errorMessage: username.errorMessage,
          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'Email',
            // OLD Solution without Cubit
            // onChanged: (value) => email = value,

            // Solution using Cubit
            onChanged: (value) {
              registerCubit.emailChanged(value);
              // _formKey.currentState?.validate();
            },
            errorMessage: email.errorMessage,
          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'Password',
            obscurePassword: true,
            // OLD Solution without Cubit
            // onChanged: (value) => password = value,

            // Solution using Cubit
            // onChanged: (value) {
            //   registerCubit.passwordChanged(value);
            //   // _formKey.currentState?.validate();
            // },
            onChanged: registerCubit.passwordChanged,
            errorMessage: password.errorMessage,
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: () {
              // print('$username, $email, $password');

              // not more necessary after use register cubit state
              // final isValid = _formKey.currentState!.validate();
              // if (!isValid) return;

              registerCubit.onSubmit();

            },
            icon: const Icon(Icons.save),
            label: const Text('Submit', style: TextStyle(fontSize: 25)),
          ),

        ],
      ),
    );
  }
}
