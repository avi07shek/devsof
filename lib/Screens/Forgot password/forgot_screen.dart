import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/auth_view_model.dart';
import '../../view_models/global_auth_view_model.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  var _isVisible = false;

  TextEditingController _emailController = TextEditingController();

  void resetPassword() async {
    _ui.loadState(true);
    try {
      await _auth.resetPassword(_emailController.text).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password reset link has been sent to your email.")));
        Navigator.of(context).pop();
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

  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 110),
                  // color: Colors.blue,
                  height: deviceHeight * 0.50,
                  child: Image.asset(
                    'assets/images/HamroPasal.png',
                    height: 400,
                  ),
                ),
                Container(
                  height: deviceHeight * 0.60,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: LayoutBuilder(builder: (ctx, constraints) {
                    return SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Reset your password',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.04),
                          Container(
                            child: Center(
                              child: TextFormField(
                                controller: _emailController,
                                validator: (String? value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return 'Please enter valid email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[350],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Color(0xFFF57C00),
                                    size: 25,
                                  ),
                                  hintText: 'Enter your email',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.04),
                          Container(
                            width: 300,
                            height: constraints.maxHeight * 0.14,
                            margin: EdgeInsets.only(
                              top: constraints.maxHeight * 0.05,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                resetPassword();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFF57C00),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
