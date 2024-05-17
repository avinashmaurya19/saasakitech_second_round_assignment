// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:saasakitech_second_round_assignment/model/user_model.dart';

// class UserPageAdd extends StatefulWidget {
//   const UserPageAdd({super.key});

//   @override
//   State<StatefulWidget> createState() => _UserPageAddState();
// }

// class _UserPageAddState extends State<UserPageAdd> {
//   final controllerTitle = TextEditingController();
//   final controllerDescription = TextEditingController();
//   final controllerDeadline = TextEditingController();
//   final controllerExpectedTaskDuration = TextEditingController();
//   bool isCompleted = false;

//   final format = DateFormat("yyyy-MM-dd HH:mm");

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text('Add User'),
//         ),
//         body: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             TextField(
//               controller: controllerTitle,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Title',
//               ),
//             ),
//             const SizedBox(height: 24),
//             TextField(
//               controller: controllerDescription,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Description',
//               ),
//             ),
//             const SizedBox(height: 24),
//             TextField(
//               controller: controllerDeadline,
//               readOnly: true,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Deadline (yyyy-MM-dd HH:mm)',
//               ),
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2101),
//                 );

//                 if (pickedDate != null) {
//                   TimeOfDay? pickedTime = await showTimePicker(
//                     context: context,
//                     initialTime: TimeOfDay.now(),
//                   );

//                   if (pickedTime != null) {
//                     final dateTime = DateTime(
//                       pickedDate.year,
//                       pickedDate.month,
//                       pickedDate.day,
//                       pickedTime.hour,
//                       pickedTime.minute,
//                     );

//                     setState(() {
//                       controllerDeadline.text = format.format(dateTime);
//                     });
//                   }
//                 }
//               },
//             ),
//             const SizedBox(height: 24),
//             TextField(
//               controller: controllerExpectedTaskDuration,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Expected Task Duration',
//               ),
//             ),
//             const SizedBox(height: 24),
//             // CheckboxListTile(
//             //   title: const Text('Mark as Complete'),
//             //   value: isCompleted,
//             //   onChanged: (bool? value) {
//             //     setState(() {
//             //       isCompleted = value!;
//             //     });
//             //   },
//             // ),
//             const SizedBox(height: 32),
//             ElevatedButton(
//                 onPressed: () {
//                   final deadline = DateFormat("yyyy-MM-dd HH:mm")
//                       .parse(controllerDeadline.text);
//                   final user = User(
//                     title: controllerTitle.text,
//                     description: controllerDescription.text,
//                     deadline: deadline,
//                     expetedTaskDuration: controllerExpectedTaskDuration.text,
//                     completed: isCompleted,
//                   );
//                   createUser(user);
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Add'))
//           ],
//         ),
//       );

//   Future createUser(User user) async {
//     final docUser = FirebaseFirestore.instance.collection('users').doc();
//     user.id = docUser.id; // Set the document ID to the user object

//     final json = user.toJson();
//     await docUser.set(json);
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saasakitech_second_round_assignment/model/user_model.dart';

class UserPageAdd extends StatefulWidget {
  const UserPageAdd({super.key});

  @override
  State<StatefulWidget> createState() => _UserPageAddState();
}

class _UserPageAddState extends State<UserPageAdd> {
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerDeadline = TextEditingController();
  final controllerExpectedTaskDuration = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isCompleted = false;
  bool isButtonEnabled = false;

  final format = DateFormat("yyyy-MM-dd HH:mm");

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = controllerTitle.text.isNotEmpty &&
          controllerDescription.text.isNotEmpty &&
          controllerDeadline.text.isNotEmpty &&
          controllerExpectedTaskDuration.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    controllerTitle.addListener(_updateButtonState);
    controllerDescription.addListener(_updateButtonState);
    controllerDeadline.addListener(_updateButtonState);
    controllerExpectedTaskDuration.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    controllerTitle.removeListener(_updateButtonState);
    controllerDescription.removeListener(_updateButtonState);
    controllerDeadline.removeListener(_updateButtonState);
    controllerExpectedTaskDuration.removeListener(_updateButtonState);
    controllerTitle.dispose();
    controllerDescription.dispose();
    controllerDeadline.dispose();
    controllerExpectedTaskDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add User'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: controllerTitle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: controllerDescription,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: controllerDeadline,
                readOnly: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Deadline (yyyy-MM-dd HH:mm)',
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      final dateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );

                      setState(() {
                        controllerDeadline.text = format.format(dateTime);
                      });
                    }
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a deadline';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: controllerExpectedTaskDuration,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Expected Task Duration',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expected task duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          final deadline = DateFormat("yyyy-MM-dd HH:mm")
                              .parse(controllerDeadline.text);
                          final user = User(
                            title: controllerTitle.text,
                            description: controllerDescription.text,
                            deadline: deadline,
                            expetedTaskDuration:
                                controllerExpectedTaskDuration.text,
                            completed: isCompleted,
                          );
                          createUser(user);
                          Navigator.pop(context);
                        }
                      }
                    : null,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      );

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id; // Set the document ID to the user object

    final json = user.toJson();
    await docUser.set(json);
  }
}
