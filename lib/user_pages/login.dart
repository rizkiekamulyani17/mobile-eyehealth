
import 'package:Eye_Health/services/auth.dart';
import 'package:Eye_Health/user_pages/forgotpass.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Form Key for validation
  bool isHidden1 = true;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  AuthService _authService = AuthService();

  String? _emailError;
  String? _passwordError;

  void _login(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final response = await _authService.login(emailC.text, passC.text);

        // Safely access the 'message' field, with a fallback to a default message
        final message = response["message"] ?? "Terjadi Kesalahan!";
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));

        // Check if the login was successful (status is true)
        if (response["status"] == true) {
          // If login is successful, navigate to Home
          Navigator.pushNamed(
            context,
            '/',
          );
        } else {
          final String error = response["error"];
          print(error);
          // If the error contains 'email', show that error
          if (error == "Email Tidak ditemukan!") {
            setState(() {
              // Set the email error (you can use this in your UI for better feedback)
              _emailError = error;
              _passwordError = null;
            });
          }

          // If the error contains 'password', show that error
          if (error == "Password Salah!") {
            setState(() {
              _emailError = null;
              _passwordError = error;
            });
          }
        }
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(227, 255, 253, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(227, 255, 253, 1),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SizedBox(
          height: 500,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 40),
            scrollDirection: Axis.vertical,
            children: [
              Form(
                key: _formKey, // Attach the form key here
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Eye",
                          style: TextStyle(
                              color: Color.fromRGBO(65, 193, 186, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Health",
                          style: TextStyle(
                            color: Color.fromRGBO(54, 91, 109, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailC,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "Email",
                              errorText: _emailError,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan Emal!';
                              }
                              final emailRegex = RegExp(
                                  r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                              if (!emailRegex.hasMatch(value)) {
                                return 'Email tidak valid!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: passC,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            obscureText: isHidden1,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: "Password",
                              errorText: _passwordError,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isHidden1 = !isHidden1;
                                  });
                                },
                                icon: Icon(
                                  isHidden1
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan Password!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () async {
                              _login(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            child: const Text(
                              "Masuk",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Belum punya akun?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/register',
                                  );
                                },
                                child: Text(
                                  "Buat akun",
                                  style: TextStyle(
                                    color: Colors.blue[300],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPass()),
                                  );
                                },
                                child: Text(
                                  "Lupa Password?",
                                  style: TextStyle(
                                    color: Colors.blue[300],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
