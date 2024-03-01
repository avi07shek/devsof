import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  Widget divider() {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: Text('Change your Email'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        color: Color(0xFFD6D6D6),
        child: ListView(
          children: [
            colorTiles(),
          ],
        ),
      ),
      bottomNavigationBar: SubmitButtons(),
    );
  }
  Widget colorTiles() {
    return Padding(
      padding: const EdgeInsets.symmetric
        (horizontal: 10,
          vertical: 50),
      child:
      Container(
        decoration:
        BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only
                (top: 20),
              child: Column(
                children: <Widget>
                [
                  Text("Previous Email:",
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:Colors.black,
                  ),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                    child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value != null || value!.isEmpty) {
                            final bool isValid =
                            EmailValidator.validate(emailController.text.trim());
                            if (!isValid) {
                              return "Invalid email";
                            }
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.deepOrange,
                        cursorHeight: 25,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[350],
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: Colors.deepOrange,
                            size: 25,
                          ),
                          hintText: "Enter your previous email...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.black38)),
                        )
                    ),
                  ),
                ],
              ),
            ),divider(),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children:<Widget>[
                  Text("New Email:",
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:Colors.black,
                  ),),
                  Padding(
                    padding: const
                    EdgeInsets.symmetric
                      (horizontal: 15, vertical: 30),
                    child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value != null || value!.isEmpty) {
                            final bool isValid =
                            EmailValidator.validate(emailController.text.trim());
                            if (!isValid) {
                              return "Invalid email";
                            }
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.deepOrange,
                        cursorHeight: 25,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[350],
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: Colors.deepOrange,
                            size: 25,
                          ),
                          hintText: "Enter your new email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.black38)),
                        )
                    ),
                  ),
                ],
              ),
            ),divider(),

            Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>
                [
                  Text("Confirm-Email:",
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:Colors.black,
                  ),),
                  Padding(
                    padding: const
                    EdgeInsets.symmetric
                      (horizontal: 15, vertical: 30),
                    child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value != null || value!.isEmpty) {
                            final bool isValid =
                            EmailValidator.validate
                              (emailController.text.trim());
                            if (!isValid) {
                              return "Invalid email";
                            }
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.deepOrange,
                        cursorHeight: 25,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[350],
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: Colors.deepOrange,
                            size: 25,
                          ),
                          hintText: "Verify your email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.black38)),
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }
  Widget SubmitButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric
        (horizontal: 50, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          onPressed: () {
            // Add your code for logging out here
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: const Text(
            "Submit",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
