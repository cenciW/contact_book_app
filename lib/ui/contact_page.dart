import 'dart:io';

import 'package:contact_book_app/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;

  //between {} is optional
  ContactPage({this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact? _editedContact;
  bool? _userEdited;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact!.toMap());

      //taking the contacts data and getting the atr
      _nameController.text = _editedContact!.name!;
      _emailController.text = _editedContact!.email!;
      _phoneController.text = _editedContact!.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //if doesn't have a contact, it's a new contact
        title: Text(_editedContact?.name ?? "Novo Contato"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: _editedContact!.img != null
                          ? FileImage(File(_editedContact!.img!))
                          : AssetImage('images/person.png') as ImageProvider),
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                label: Text("Nome"),
              ),
              onChanged: (text) {
                _userEdited = true;
                _editedContact!.name = text;
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                label: Text("Email"),
              ),
              onChanged: (text) {
                _userEdited = true;
                _editedContact!.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                label: Text("Telefone"),
              ),
              onChanged: (text) {
                _userEdited = true;
                _editedContact!.phone = text;
              },
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}
