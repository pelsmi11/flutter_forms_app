import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("nuevo usuario")),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlutterLogo(
                    size: 100,
                  ),
                  _RegisterForm(),
                ]),
          )),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
              label: "Nombre de usuario",
              onChange: (value) {
                registerCubit.usernameChange(value);
                _formKey.currentState?.validate();
              },
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "El nombre de usuario es requerido";
                }
                if (p0.trim().isEmpty) {
                  return "El nombre de usuario es requerido";
                }
                if (p0.trim().length < 6) {
                  return "mayor a 6 caracteres";
                }

                return null;
              }),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              label: "Correo electrónico",
              onChange: (value) {
                registerCubit.emailChange(value);
                _formKey.currentState?.validate();
              },
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "El correo es requerido";
                }
                if (p0.trim().isEmpty) {
                  return "El correo es requerido";
                }
                final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegExp.hasMatch(p0)) {
                  return "El correo no es válido";
                }

                return null;
              }),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              label: "Contraseña",
              obscureText: true,
              onChange: (value) {
                registerCubit.passwordChange(value);
                _formKey.currentState?.validate();
              },
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "La contraseña es requerida";
                }
                if (p0.trim().isEmpty) {
                  return "La contraseña es requerida";
                }
                if (p0.trim().length < 6) {
                  return "mayor a 6 caracteres";
                }

                return null;
              }),
          const SizedBox(
            height: 20,
          ),
          FilledButton.tonalIcon(
              onPressed: () {
                final isValid = _formKey.currentState!.validate();

                if (!isValid) return;
                registerCubit.onSubmit();
              },
              icon: const Icon(Icons.save),
              label: const Text("Crear usuario")),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
