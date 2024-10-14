import 'dart:io';

import 'package:contact_book_app/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //é singleton, static ou seja, independente de quantos n instanciar sempre será o mesmo
  ContactHelper contactHelper = ContactHelper();

  List<Contact>? contacts;

  @override
  void initState() {
    super.initState();
    // Contact c = Contact();
    // c.name = "José Augusto";
    // c.email = "ze @gmail";
    // c.phone = "123456";
    // c.img = "person";
    // contactHelper.saveContact(c);

    contactHelper.getAllContacts().then((list) {
      setState(() {
        contacts = list.cast<Contact>();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contacts?.length ?? 0,
        itemBuilder: (context, index) {
          return _contactCard(context, index);
        },
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    final contact = contacts?[index];
    if (contact == null) return SizedBox.shrink();

    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          //now the content
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contact.img != null
                          ? FileImage(File(contact.img!))
                          : AssetImage('images/person.png') as ImageProvider),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name ?? "",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      contact.email ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      contact.phone ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
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
