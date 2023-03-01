import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/NotificationService.dart';
import 'GlobalUIViewModel.dart';
import 'UserModel.dart';
import 'authViewModel.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureConfirmTextPassword = true;

  final _formKey = GlobalKey<FormState>();

  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;

  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  void register() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _ui.loadState(true);
    try {
      await _authViewModel
          .register(UserModel(
              email: _emailController.text,
              password: _passwordController.text,
              phone: _phoneController.text,
              username: _userNameController.text,
              name: _nameController.text))
          .then((value) {
        NotificationService.display(
          title: "Welcome to Raila Gang",
          body:
              "Hello ${_authViewModel.loggedInUser?.name},\n Thank you for registering in this application.",
        );
        Navigator.of(context).pushReplacementNamed("/Navigation");
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                // color: Color.fromRGBO(0, 0, 128, 10),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Get Started!",
                  style: GoogleFonts.oswald(
                      fontStyle: FontStyle.normal,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "First Name",
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.person),
                      hintText: "Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "Phone number",
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.phone),
                      hintText: "98xxxxxxxx"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _userNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "User Name",
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.person_pin),
                      hintText: "username"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "Email",
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.email),
                      hintText: "chillktaho@gmail.com"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureTextPassword,
                  validator: (String? value) => ValidateSignup.password(
                      value, _confirmPasswordController),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      "Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.password),
                    hintText: "********",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureTextPassword = !_obscureTextPassword;
                        });
                      },
                      child: Icon(
                        _obscureTextPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _obscureConfirmTextPassword,
                  controller: _confirmPasswordController,
                  validator: (String? value) =>
                      ValidateSignup.password(value, _passwordController),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      "Confirm Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: "********",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureConfirmTextPassword =
                              !_obscureConfirmTextPassword;
                        });
                      },
                      child: Icon(
                        _obscureConfirmTextPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pushNamed("/ForgotPassword");
                        });
                      },
                      child: Text("Forgot password??",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    )),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      register();
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).pushNamed("/UserLogin");
                    });
                  },
                  child: Text(
                    "Already have an account? Log in!",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ValidateSignup {
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  static String? emailValidate(String? value) {
    final RegExp emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!emailValid.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is required";
    }
    return null;
  }

  static String? password(String? value, TextEditingController otherPassword) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password should be at least 8 character";
    }
    if (otherPassword.text != value) {
      return "Please make sure both the password are the same";
    }
    return null;
  }
}
