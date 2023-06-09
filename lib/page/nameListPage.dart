import 'package:flutter/material.dart';
import 'package:personal_data_app/page/addDataPage.dart';
import '../model/person.dart';

class NameListPage extends StatefulWidget {
  const NameListPage({Key? key}) : super(key: key);

  @override
  _NameListPageState createState() => _NameListPageState();
}

class _NameListPageState extends State<NameListPage> {
  List<Person> persons = generatePersonList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Name List'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All Names'),
              Tab(text: 'Names by Province'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: persons.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    shadowColor: Colors.blueAccent,
                    child: Center(
                      child: ListTile(
                        title: Text(persons[index].name),
                        subtitle: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      'Province: ${persons[index].province}\n'),
                              TextSpan(
                                  text: 'ID Card: ${persons[index].idCard}'),
                            ],
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.6,
                                color:
                                    Colors.black // Adjust the line spacing here
                                ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteConfirmationDialog(index);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: getCountries(persons).length,
              itemBuilder: (context, index) {
                final province = getCountries(persons)[index];
                final countryPersons = persons
                    .where((person) => person.province == province)
                    .toList();
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(18.0)),
                        width: 200,
                        child: ListTile(
                          title: Align(
                            alignment: Alignment.center,
                            child: Text(
                              province,
                              style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: countryPersons.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              shadowColor: Colors.blueAccent,
                              child: Center(
                                child: ListTile(
                                  title: Text(countryPersons[index].name),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      final personIndex = persons
                                          .indexOf(countryPersons[index]);
                                      _showDeleteConfirmationDialog(
                                          personIndex);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // Show a dialog to add a new person

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddDataPage()));
          },
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this person?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  persons.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<String> getCountries(List<Person> persons) {
    return persons.map((person) => person.province).toSet().toList();
  }
}

// class Person {
//   final String name;
//   final String country;

//   Person(this.name, this.country);
// }

// List<Person> generatePersonList() {
//   return [
//     Person('Wave', 'Thailand'),
//     Person('Chayen', 'Thailand'),
//     Person('Model', 'United States'),
//     Person('Dimoo', 'United States'),
//   ];
// }



// class NameListPage extends StatefulWidget {
//   const NameListPage({super.key});

//   @override
//   State<NameListPage> createState() => _NameListPageState();
// }

// class _NameListPageState extends State<NameListPage> {
//   List<String> names = ['wave','chayen','model','dimoo']; // List to store the names

//   // Function to show a confirmation dialog before deleting a name
//   Future<void> _showDeleteConfirmationDialog(int index) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Deletion'),
//           content: Text('Are you sure you want to delete this name?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Delete'),
//               onPressed: () {
//                 setState(() {
//                   names.removeAt(index);
//                 });
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Name List'),
//       ),
//       body: ListView.builder(
//         itemCount: names.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(names[index]),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () {
//                 _showDeleteConfirmationDialog(index);
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           // Show a dialog to add a new name
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               String newName = '';

//               return AlertDialog(
//                 title: Text('Add Name'),
//                 content: TextField(
//                   onChanged: (value) {
//                     newName = value;
//                   },
//                 ),
//                 actions: <Widget>[
//                   TextButton(
//                     child: Text('Cancel'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   TextButton(
//                     child: Text('Add'),
//                     onPressed: () {
//                       setState(() {
//                         names.add(newName);
//                       });
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }