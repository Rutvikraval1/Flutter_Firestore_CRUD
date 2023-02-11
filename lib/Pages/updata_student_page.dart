import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdataStudent extends StatefulWidget {
  final String id;
  const UpdataStudent({Key? key, required this.id}) : super(key: key);

  @override
  _UpdataStudentState createState() => _UpdataStudentState();
}

class _UpdataStudentState extends State<UpdataStudent> {
  final _formkey = GlobalKey<FormState>();



  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


cleatText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }


  CollectionReference student =
      FirebaseFirestore.instance.collection('Students');

  Future<void> updateUser(id, name, email, password) {
    //print("User Update");
    return student
        .doc(id)
        .update({'name': name, 'email': email, 'password': password})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to Update user:$Error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student'),
      ),
      body: Form(
          key: _formkey,
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Students')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print("Something went worng");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['name'];
              var email = data['email'];
              var password = data['password'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        autofocus: false,
                        initialValue: name,
                        onChanged: (value) => name = value,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        initialValue: email,
                        onChanged: (value) => email = value,
                        autofocus: false,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),

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
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        initialValue: password,
                        onChanged: (value) => password = value,
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
                                updateUser(widget.id, name, email, password);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Update ',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {cleatText()},
                            child: Text(
                              'Reset',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
