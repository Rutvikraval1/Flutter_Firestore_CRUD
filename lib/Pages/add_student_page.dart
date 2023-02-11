//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentpage extends StatefulWidget {
  const AddStudentpage({Key? key}) : super(key: key);

  @override
  _AddStudentpageState createState() => _AddStudentpageState();
}

class _AddStudentpageState extends State<AddStudentpage> {
  final _formkey = GlobalKey<FormState>();

  var name = '';
  var email = '';
  var password = '';

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  cleatText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  CollectionReference student =
      FirebaseFirestore.instance.collection('Students');

  Future<void> addUser() {
    return student
        .add({'name': name, 'email': email, 'password': password})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to Add user:$Error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Student'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            name = nameController.text;
                            email = emailController.text;
                            password = passwordController.text;
                            addUser();
                            cleatText();
                          });
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {cleatText()},
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
