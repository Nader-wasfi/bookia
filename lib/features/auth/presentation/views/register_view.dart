import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create Account ✨", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFBB9967),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Hello! Register to get started", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController, 
                decoration: InputDecoration(labelText: "Username", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                validator: (value) => value == null || value.isEmpty ? "Name is required!" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController, 
                decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                validator: (value) => value == null || value.isEmpty ? "Email is required!" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController, 
                obscureText: true,
                decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                validator: (value) => value == null || value.isEmpty ? "Password is required!" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _confirmPasswordController, 
                obscureText: true,
                decoration: InputDecoration(labelText: "Confirm password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                validator: (value) {
                  if (value != _passwordController.text) return "Passwords do not match!";
                  return null;
                },
              ),
              const SizedBox(height: 30),
              BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) {
                  if (state is AuthSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.green));
                    Navigator.pop(context); 
                  }
                  if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) return const CircularProgressIndicator(color: Color(0xFFBB9967));

                  return SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBB9967), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().register(
                            _nameController.text.trim(),
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        }
                      },
                      child: const Text("REGISTER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}