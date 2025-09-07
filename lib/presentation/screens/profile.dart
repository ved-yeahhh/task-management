import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/bloc/auth/auth_bloc.dart';
import 'package:task_mgmt/bloc/auth/auth_event.dart';
import 'package:task_mgmt/bloc/auth/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Profile"),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            final user = state.user; // this is FirebaseAuth User
            return Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      child: Icon(Icons.person, size: 40.0),
                    ),
                    SizedBox(height: 16.0),
                    Text("UserName: ${user.displayName ?? 'No name'}"),
                    Text("Email: ${user.email ?? 'No email'}"),

                    SizedBox(height: 16.0),

                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthSignOutRequested());
                      },
                      child: Text("Logout"),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AuthError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return Center(child: Text("Not aaauthenticated"));
          }
        },
      ),
    );
  }
}
