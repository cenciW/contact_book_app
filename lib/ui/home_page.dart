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

    contactHelper.getAllContacts().then((list) {
      setState(() {
        // contacts = list.cast<Contact>();
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
        itemCount: contacts?.length,
        itemBuilder: (context, index) {},
      ),
    );
  }
}
