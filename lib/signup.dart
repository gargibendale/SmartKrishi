import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animate_do/animate_do.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String? _firstName, _lastName, _email, _password;

  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();
      try {
        await _auth.createUserWithEmailAndPassword(email: _email!, password: _password!);
        Navigator.pushNamed(context, '/login');
      } on FirebaseAuthException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Unknown error occurred')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Make the entire body scrollable
        child: Container(
          height: MediaQuery.of(context).size.height, // Ensure the container takes the full height of the screen
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.green.shade900,
                Colors.green.shade800,
                Colors.green.shade400,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 40))),
                    SizedBox(height: 10,),
                    FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Join us now", style: TextStyle(color: Colors.white, fontSize: 18))),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 60,),
                          FadeInUp(
                            duration: Duration(milliseconds: 1400),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )],
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.black)),
                                      ),
                                      child: TextFormField(
                                        validator: (input) => input?.isEmpty == true ? 'Enter your first name' : null,
                                        onSaved: (input) => _firstName = input,
                                        decoration: InputDecoration(
                                          hintText: "First Name",
                                          hintStyle: TextStyle(color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.black)),
                                      ),
                                      child: TextFormField(
                                        validator: (input) => input?.isEmpty == true ? 'Enter your last name' : null,
                                        onSaved: (input) => _lastName = input,
                                        decoration: InputDecoration(
                                          hintText: "Last Name",
                                          hintStyle: TextStyle(color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.black)),
                                      ),
                                      child: TextFormField(
                                        validator: (input) => input?.isEmpty == true ? 'Enter your email' : null,
                                        onSaved: (input) => _email = input,
                                        decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle: TextStyle(color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.black)),
                                      ),
                                      child: TextFormField(
                                        obscureText: true,
                                        
                                        onSaved: (input) => _password = input,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle: TextStyle(color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40,),
                          FadeInUp(
                            duration: Duration(milliseconds: 1600),
                            child: MaterialButton(
                              onPressed: _signUp,
                              height: 50,
                              color: Colors.green.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          FadeInUp(
                            duration: Duration(milliseconds: 1700),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text("Already have an account? Login", style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
