
import 'package:Eye_Health/services/auth.dart';
import 'package:Eye_Health/user_pages/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  AuthService _authService = AuthService();

  bool isHidden1 = true;
  bool isHidden2 = true;

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1700),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        tanggallahirC.text =
            DateFormat('yyyy-MM-dd').format(picked); // Format the date
      });
    }
  }

  TextEditingController namaC = TextEditingController();
  TextEditingController tanggallahirC = TextEditingController();
  TextEditingController tempatlahirC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController konfirmpassC = TextEditingController();

  String? _emailError;

  // Check if passwords match and ensure length >= 4
  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong!';
    }
    if (value.length < 4) {
      return 'Password minimal 4 karakter!';
    }
    return null;
  }

  // Ensure the confirmation password matches the password
  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi Password tidak boleh kosong!';
    }
    if (value != passC.text) {
      return 'Konfirmasi Password harus sama dengan Password!';
    }
    return null;
  }

  void _register(context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await _authService.register(
          namaC.text,
          emailC.text,
          passC.text,
          tempatlahirC.text,
          tanggallahirC.text,
          alamatC.text,
        );
        if (response["status"]) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response["message"])));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          // Set email error from the response if any
          setState(() {
            _emailError = response["error"] ?? null;
          });
        }
      } catch (e) {
        print(e);
      }
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Eye",
                    style: TextStyle(
                        color: Color.fromRGBO(65, 193, 186, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Health",
                    style: TextStyle(
                      color: Color.fromRGBO(54, 91, 109, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namaC,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: "Nama",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row for Birthplace and DatePicker
                      Row(
                        children: [
                          // Expanded for Birthplace field
                          Expanded(
                            child: TextFormField(
                              controller: tempatlahirC,
                              decoration: const InputDecoration(
                                labelText: "Tempat Lahir", // Birthplace
                              ),
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tempat Lahir tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10), // Space between fields
                          // Expanded for Date Picker
                          Expanded(
                            child: TextFormField(
                              controller: tanggallahirC,
                              decoration: const InputDecoration(
                                labelText: "Tanggal Lahir", // Date of Birth
                              ),
                              readOnly: true,
                              onTap: () {
                                _selectDate(); // Open date picker on tap
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tanggal Lahir tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: alamatC,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: "Alamat",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Alamat tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailC,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Email",
                          errorText: _emailError, // Display the error
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passC,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        obscureText: isHidden1,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: "Password",
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
                        validator: _passwordValidator,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: konfirmpassC,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        obscureText: isHidden2,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: "Konfirmasi Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHidden2 = !isHidden2;
                              });
                            },
                            icon: Icon(
                              isHidden2
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: _confirmPasswordValidator,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _register(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: const Text(
                          "Daftar",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sudah punya akun?",
                            style: TextStyle(),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/login',
                              );
                            },
                            child: Text(
                              "Masuk",
                              style: TextStyle(
                                color: Colors.blue[300],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
