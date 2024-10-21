import 'dart:io';

import 'package:contact_book_app/helpers/contact_helper.dart';
import 'package:contact_book_app/ui/contact_page.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

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
    // c.img = "images/person.png";
    // contactHelper.saveContact(c);
    _getAllContacts();
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
        onPressed: () {
          _showContactPage();
        },
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
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contact.img != null && contact.img!.isNotEmpty
                        ? FileImage(File(contact.img!))
                        : AssetImage('images/person.png'),
                    fit: BoxFit.cover,
                  ),
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
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: () {
                          launchUrl(
                              Uri.parse("tel:${contacts?[index].phone!}"));
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Ligar",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          launchUrl(
                              Uri.parse("sms:${contacts?[index].phone!}"));
                        },
                        child: Text(
                          "Enviar SMS",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showContactPage(contact: contacts?[index]);
                        },
                        child: Text(
                          "Editar",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            contactHelper.deleteContact(contacts![index].id!);
                            contacts?.removeAt(index);
                            //fechar a janelinha
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          "Deletar",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            onClosing: () {},
          );
        });
  }

  void _showContactPage({Contact? contact}) async {
    final recContact = await Navigator.push(
      context,
      //sending data to next page
      MaterialPageRoute(
        builder: (context) => ContactPage(
          contact: contact,
        ),
      ),
    );

    if (recContact != null) {
      if (contact != null) {
        await contactHelper.updateContact(recContact);
      } else {
        await contactHelper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    contactHelper.getAllContacts().then((list) {
      setState(() {
        contacts = list.cast<Contact>();
        print("contacts: $contacts");
      });
    });
  }
}
