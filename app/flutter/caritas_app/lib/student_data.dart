class Student {
  final String fullName;
  final String rfid;

  const Student({this.fullName, this.rfid});
}
const kStudent = const <Student>[
    const Student(
      fullName: 'Jacky Chan',
      rfid:'666'
    ),
    const Student(
      fullName: 'Don Wong',
      rfid:'777'
    ),
    const Student(
      fullName: 'Mickey Wong',
      rfid:'888'
    )
];