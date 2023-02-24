import 'dart:developer';

import 'package:chat_application/src/pages/group/group_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController namecontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Chat App'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Please Enter your Name'),
              content: Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.length < 2) {
                      return "Please provide your name";
                    }
                  },
                  controller: namecontroller,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red.shade300, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    log(namecontroller.text);
                    if (formKey.currentState!.validate()) {
                      String name = namecontroller.text;
                      namecontroller.clear();
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupPage(name: name),
                          ));
                    }
                  },
                  child: const Text(
                    'Enter',
                    style: TextStyle(color: Colors.lightGreen, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          child: const Text(
            "Initiate Group Chat",
            style: TextStyle(
              color: Colors.teal,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
