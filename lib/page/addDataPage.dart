import 'package:flutter/material.dart';

import '../model/person.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  int currentStep = 0;
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController religionController;
  late TextEditingController idCardController;
  late TextEditingController addressController;
  late TextEditingController provinceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
    religionController = TextEditingController();
    idCardController = TextEditingController();
    addressController = TextEditingController();
    provinceController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    religionController.dispose();
    idCardController.dispose();
    addressController.dispose();
    provinceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: () {
          if (currentStep == 1) {
            // Handle submit or save operation
            _saveData();
          } else {
            setState(() {
              currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep -= 1;
            });
          } else {
            Navigator.pop(context);
          }
        },
        steps: [
          Step(
            title: Text('Collect Personal Information'),
            content: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age'),
                ),
                TextField(
                  controller: religionController,
                  decoration: InputDecoration(labelText: 'Religion'),
                ),
              ],
            ),
            isActive: currentStep == 0,
          ),
          Step(
            title: Text('Collect Address Information'),
            content: Column(
              children: [
                TextField(
                  controller: idCardController,
                  decoration: InputDecoration(labelText: 'ID Card'),
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: provinceController,
                  decoration: InputDecoration(labelText: 'Province'),
                ),
              ],
            ),
            isActive: currentStep == 1,
          ),
        ],
      ),
    );
  }

  void _saveData() {
    final String name = nameController.text ?? '';
    final int age = int.tryParse(ageController.text) ?? 0;
    final String religion = religionController.text ?? '';
    final String idCard = idCardController.text ?? '';
    final String address = addressController.text ?? '';
    final String province = provinceController.text ?? '';
    // Check if any of the required fields are empty
    if (name.isEmpty || age.toString().isEmpty || religion.isEmpty ||idCard.isEmpty || address.isEmpty || province.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return; 
    }

    // Create a Person object and save the data
    final Person newPerson = Person(name, age, religion, idCard, address, province);
    // Handle saving the data or performing any other operations

    // Reset the form and navigate back
    nameController.clear();
    idCardController.clear();
    addressController.clear();
    setState(() {
      currentStep = 0;
    });
    Navigator.pop(context, newPerson);
  }
}
