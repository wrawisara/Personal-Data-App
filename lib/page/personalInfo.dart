import 'package:flutter/material.dart';
import 'package:personal_data_app/page/nameListPage.dart';
import '../model/person.dart';

class PersonalInfoPage extends StatefulWidget {
  final Person person;
  
  const PersonalInfoPage({Key? key, required this.person}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),
                image: const DecorationImage(
                  image: AssetImage('assets/img/bg.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text(
                "Personal Information",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: (MediaQuery.of(context).size.height) / 3.8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),
                color: Colors.blue[50],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Name: ${widget.person.name}',
                     
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  Text(
                    'Age: ${widget.person.age.toString()}',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  Text('Religion: ${widget.person.religion}',
                      style: TextStyle(fontSize: 16, height: 1.5)),
                  Text('Province: ${widget.person.province}',
                      style: TextStyle(fontSize: 16, height: 1.5)),
                  Text('Address: ${widget.person.address}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, height: 1.5)),
                  Text('ID Card: ${widget.person.idCard}',
                      style: TextStyle(fontSize: 16, height: 1.5)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(260, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  child: const Text('Ok',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
