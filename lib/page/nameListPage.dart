import 'package:flutter/material.dart';
import 'package:personal_data_app/page/addDataPage.dart';
import 'package:personal_data_app/page/personalInfo.dart';
import '../model/person.dart';

class NameListPage extends StatefulWidget {
  final List<Person> persons;
  NameListPage({required this.persons});

  @override
  _NameListPageState createState() => _NameListPageState();
}

class _NameListPageState extends State<NameListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
              itemCount: widget.persons.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    final updatedPerson = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PersonalInfoPage(person: widget.persons[index]),
                      ),
                    );

                    if (updatedPerson != null) {
                      setState(() {
                        widget.persons[index] = updatedPerson;
                      });
                    }
                  },
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      shadowColor: Colors.blueAccent,
                      child: Center(
                        child: ListTile(
                          title: Text(widget.persons[index].name),
                          subtitle: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'Province: ${widget.persons[index].province}\n'),
                                TextSpan(
                                    text:
                                        'ID Card: ${widget.persons[index].idCard}'),
                              ],
                              style: TextStyle(
                                  fontSize: 14,
                                  height: 1.6,
                                  color: Colors.black),
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
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: getProvinces(widget.persons).length,
              itemBuilder: (context, outerindex) {
                final province = getProvinces(widget.persons)[outerindex];
                final provincePersons = widget.persons
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
                        itemCount: provincePersons.length,
                        itemBuilder: (context, innerindex) {
                          final person = provincePersons[innerindex];
                          return GestureDetector(
                            onTap: () async {
                              final updatedPerson = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PersonalInfoPage(
                                      person: widget.persons.firstWhere(
                          (p) => p.idCard == person.idCard,
                        ),
                                ),
                              ));
                              if (updatedPerson != null) {
                                setState(() {
                                  final index = widget.persons.indexOf(person);
                                  widget.persons[index] = updatedPerson;
                                  // widget.persons[index] = updatedPerson;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                shadowColor: Colors.blueAccent,
                                child: Center(
                                  child: ListTile(
                                    title: Text(person.name),
                                    subtitle: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'Province: ${person.province}\n',
                                          ),
                                          TextSpan(
                                            text: 'ID Card: ${person.idCard}',
                                          ),
                                        ],
                                        style: TextStyle(
                                          fontSize: 14,
                                          height: 1.6,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _showDeleteConfirmationDialog( widget.persons.indexOf(person));
                                      },
                                    ),
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
          onPressed: () async {
            final updatedPerson = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDataPage(
                  persons: widget.persons,
                ),
              ),
            );

            if (updatedPerson != null) {
              setState(() {
                widget.persons.clear();
                widget.persons.addAll(updatedPerson);
              });
            }
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
                  widget.persons.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<String> getProvinces(List<Person> persons) {
    return persons.map((person) => person.province).toSet().toList();
  }
}
