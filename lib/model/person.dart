class Person {
  final String name;
  final int age;
  final String religion;
  final String province;
  final String address;
  final String idCard;

  Person(this.name, this.age, this.religion, this.province, this.address, this.idCard);
   @override
  String toString() {
    return 'Person(name: $name, age: $age, religion: $religion, province: $province, address: $address, idCard: $idCard)';
  }
}

// List<Person> generatePersonList() {
//   return [
//     Person('Wave', 22,'Buddhism', 'Bangkok','2 Village No.5 Ladprao Road, Ladprao Sub-district, Ladprao District','1100702587964'),
//     Person('Chayen', 18, 'Buddhism', 'Chiang mai','85/7 muang','1100796823547'),
//     Person('pakkad', 30, 'Buddhism','Rayong','984/3 muang','1100896532147'),
//     Person('Dimoo', 45, 'Buddhism','Bangkok','25 saimai 30','1100851366524'),
//   ];
// }
