import 'package:flutter/material.dart';

import '../model/person.dart';

class AddDataPage extends StatefulWidget {
  final List<Person> persons;
  AddDataPage({required this.persons});

  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  Person person = Person('', 0, '', '', '', '');

  int currentStep = 0;
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController religionController;
  late TextEditingController idCardController;
  late TextEditingController addressController;
  late String selectedProvince;
  // late TextEditingController provinceController;

  final List<String> provinces = [
    'Bangkok',
    'Rayong',
    'Phuket',
    'Chiang mai',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
    religionController = TextEditingController();
    idCardController = TextEditingController();
    addressController = TextEditingController();
    selectedProvince = provinces[0];
    // provinceController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    religionController.dispose();
    idCardController.dispose();
    addressController.dispose();
    // provinceController.dispose();
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
            _saveData().then((updatedPersons) {
              if (updatedPersons != null) {
                Navigator.pop(context, updatedPersons);
              }
            });
          } else {
            setState(() {
              currentStep += 1;
            });
          }
        },
        // onStepContinue: () {
        //   if (currentStep == 1) {
        //     // Handle submit or save operation
        //     _saveData();
        //   } else {
        //     setState(() {
        //       currentStep += 1;
        //     });
        //   }
        // },
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
                DropdownButtonFormField<String>(
                  value: selectedProvince,
                  decoration: InputDecoration(labelText: 'Province'),
                  items: provinces.map((String province) {
                    return DropdownMenuItem<String>(
                      value: province,
                      child: Text(province),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedProvince = newValue!;
                    });
                  },
                ),
              ],
            ),
            isActive: currentStep == 1,
          ),
        ],
      ),
    );
  }

  Future<List<Person>> _saveData() async {
    final String name = nameController.text ?? '';
    final int age = int.tryParse(ageController.text) ?? 0;
    final String religion = religionController.text ?? '';
    final String idCard = idCardController.text ?? '';
    final String address = addressController.text ?? '';
    final String province = selectedProvince;

    // Check if any of the required fields are empty
    if (name.isEmpty ||
        age.toString().isEmpty ||
        religion.isEmpty ||
        idCard.isEmpty ||
        address.isEmpty ||
        selectedProvince.isEmpty) {
      await showDialog(
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
      return widget.persons; // Return the current list without any changes
    }

    print(province);
    // Create a Person object and save the data
    final Person newPerson =
        Person(name, age, religion, province, address, idCard);
    final updatedList = List<Person>.from(widget.persons)..add(newPerson);

    setState(() {
      widget.persons.clear();
      widget.persons.addAll(updatedList);
    });

    nameController.clear();
    ageController.clear();
    religionController.clear();
    idCardController.clear();
    addressController.clear();
    setState(() {
      currentStep = 0;
    });
    print(updatedList);
    return updatedList; // Return the updated list with the new person added
  }

}
