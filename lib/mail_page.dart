import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MailPage extends StatefulWidget {
  const MailPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  String toEmail = "";
  String fromEmail = "";
  String name = "";
  String subject = "";
  String message = "";
  bool progress = false;

  validation() {
    if (toEmail != "" &&
        fromEmail != "" &&
        name != "" &&
        subject != "" &&
        message != "") {
      // setState(() {
      //   progress = true;
      // });
      // _sendEmail();
    } else {
      setState(() {
        progress = false;
      });
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text("All fields are required!")));
    }
  }

  Future _sendEmail() async {
    final String serviceId = "service_gke8ego";
    final String templateId = "template_0aopi8a";
    final String userId = "user_KyTEzx37mzWsgE6hcU7qF";

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_email': toEmail,
            'from_email': fromEmail,
            'from_name': name,
            'message': message,
            'subject': subject,
          }
        }));
    if(response.body =="OK"){
      setState(() {
        progress = false;
      });
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text("Email Sent Successfully.")));
    }else{
      setState(() {
        progress = false;
      });
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text("Something went wrong!")));
    }


  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "To Email",
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "Email Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                  )),
              onChanged: (String value) {
                toEmail = value;
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Your Email",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "Email Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                  )),
              onChanged: (String value) {
                fromEmail = value;
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "From",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "Full Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                  )),
              onChanged: (String value) {
                name = value;
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Subject",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "Enter Your Subject",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                  )),
              onChanged: (String value) {
                subject = value;
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Message",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "Enter Your Message Here.....",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                  )),
              onChanged: (String value) {
                message = value;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(
              height: 20,
            ),
            Center(child: progress?CircularProgressIndicator(color: Colors.red,):Container()),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => validation(),
        child: const Icon(
          Icons.mail_outline_outlined,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
