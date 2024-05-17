import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saasakitech_second_round_assignment/helper.dart';
import 'package:saasakitech_second_round_assignment/model/user_model.dart';
import 'package:saasakitech_second_round_assignment/screens/email_auth/login_screen.dart';
import 'package:saasakitech_second_round_assignment/view/user_page_add.dart';
import 'package:saasakitech_second_round_assignment/view/user_page_edit.dart';

class UserPageList extends StatefulWidget {
  const UserPageList({super.key});

  @override
  State<StatefulWidget> createState() => _UserPageListState();
}

class _UserPageListState extends State<UserPageList> {
  Future updateUserCompletion(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(user.id);
    await docUser.update({'completed': user.completed});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('All Users'),
          actions: [
            IconButton(
              onPressed: () {
                FireBaseLogout().logOut();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UserPageAdd(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      );

  Widget buildUser(User user) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.grey[100]),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.title,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    user.description,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    DateFormat("yyyy-MM-dd HH:mm").format(user.deadline),
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    user.expetedTaskDuration,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    user.completed ? 'Completed' : 'Incomplete',
                    style: const TextStyle(color: Colors.black),
                  ),
                  Row(
                    children: [
                      const Text('Mark as Completed'),
                      Checkbox(
                        value: user.completed,
                        onChanged: (bool? newValue) {
                          setState(() {
                            user.completed = newValue!;
                            updateUserCompletion(user);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserPageEdit(
                              id: user.id,
                              name: user.title,
                              description: user.description,
                              deadline: user.deadline,
                              expetedTaskDuration: user.expetedTaskDuration,
                              completed: user.completed,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        AlertDialog delete = AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Confirmation",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 10),
                              Text("Are you sure for deleting ${user.title}?")
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  final docUser = FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.id);
                                  docUser.delete();
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes")),
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                        showDialog(
                            context: context, builder: (context) => delete);
                      },
                      icon: const Icon(Icons.delete)),
                ],
              ),
            ],
          ),
        ),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
