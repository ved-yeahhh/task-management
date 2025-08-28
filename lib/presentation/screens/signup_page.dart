import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:task_mgmt/bloc/auth/auth_bloc.dart';
import 'package:task_mgmt/bloc/auth/auth_event.dart';
import 'package:task_mgmt/bloc/auth/auth_state.dart';
import 'package:task_mgmt/presentation/widgets/textformfield.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final logger = Logger();
  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello! Register to get started',
                      style: GoogleFonts.openSans(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 56.0),
                    SizedBox(height: 8.0),
                    Textformfield(
                      label: 'username',
                      icon: Icon(Icons.person),
                      controller: _usernameController,
                    ),
                    SizedBox(height: 8.0),
                    Textformfield(
                      label: 'email',
                      icon: Icon(Icons.email),
                      controller: _emailController,
                    ),
                    SizedBox(height: 8.0),
                    Textformfield(
                      label: 'password',
                      icon: Icon(Icons.lock),
                      controller: _passwordController,
                    ),
                    SizedBox(height: 8.0),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return MaterialButton(
                          minWidth: double.infinity,
                          height: 50.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: Colors.black,
                          child: Text(
                            'Register',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthSignUpRequested(
                                _emailController.text,
                                _passwordController.text,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
