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

  @override
  void initState() {
    super.initState();

    Contact c = Contact();
    c.name = "Jadir Junior";
    c.email = "junior@gmail.com";
    c.phone = "551999929";
    c.img = "imgteste";

    contactHelper.saveContact(c);
    contactHelper.getAllContacts().then((list) {
      print(list.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
