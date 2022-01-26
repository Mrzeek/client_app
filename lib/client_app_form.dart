import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Client_App_Form extends StatefulWidget {
  const Client_App_Form({Key? key}) : super(key: key);

  @override
  _Client_App_FormState createState() => _Client_App_FormState();
}

class _Client_App_FormState extends State<Client_App_Form> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _dbController = TextEditingController();
  final _stateofController = TextEditingController();
  String _typeDropdown = 'Upload Document';
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser() {
      return users
          .add({
            'firstname': _firstnameController.text, // John Doe
            'lastname': _lastnameController.text, // Stokes and Sons
            'date_of_birth': _dbController.text, 
            'state_of_origin': _stateofController.text,
            
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: const Text(
          'Client Application Form',
          // style: TextStyle(
          //   color: Colors.black,
          // ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      _nameInput(),
                      const SizedBox(height: 20),
                      const SizedBox(height: 10),
                      _lastnameInput(),
                      const SizedBox(height: 20),
                      _dbInput(),
                      const SizedBox(height: 20),
                      _stateofInput(),
                      const SizedBox(height: 20),
                      Center(
                        child: _staffTypeDropdown(),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            child: const Text('Send Request'),
                            onPressed: () async {
                              // ignore: avoid_print
                              print('hello');
                              await addUser();

                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _staffTypeDropdown() {
    return DropdownSearch<String>(
      maxHeight: (55 * 2).toDouble(),
      mode: Mode.MENU,
      items: const ['Agent', 'Manager'],
      dropdownSearchDecoration:
          const InputDecoration(labelText: 'Select Document'),
      onChanged: (value) => _typeDropdown = value ?? 'Agent',
      selectedItem: _typeDropdown,
    );
  }

  Widget _nameInput() {
    return TextFormField(
      controller: _firstnameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: textBorder('First Name'),
    );
  }

  Widget _lastnameInput() {
    return TextFormField(
      controller: _lastnameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: textBorder('Last Name'),
    );
  }

  Widget _dbInput() {
    return TextFormField(
      controller: _dbController,
      keyboardType: TextInputType.phone,
      decoration: textBorder('Date of Birth'),
      inputFormatters: [
        LengthLimitingTextInputFormatter(11),
      ],
    );
  }

  Widget _stateofInput() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _stateofController,
      decoration: textBorder(
        'State Of Origin',
      ),
      onChanged: (_) => setState(() {}),
    );
  }
}

class Seperator extends StatelessWidget {
  final String text;
  const Seperator(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text(text),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration textBorder(String labelText,
    {Widget? prefixIcon, Widget? suffixIcon, String? helperText}) {
  return InputDecoration(
    helperText: helperText,
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    labelText: labelText,
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(),
    ),
  );
}
